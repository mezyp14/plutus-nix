{-# LANGUAGE DataKinds #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}

module Main where

import Prelude (IO, String, FilePath, putStrLn, (<>))
import qualified Prelude as P

import Plutus.V2.Ledger.Api
import Plutus.V2.Ledger.Contexts
import PlutusTx
import PlutusTx.Prelude hiding (Semigroup(..), unless)

import Plutus.V1.Ledger.Value (valueOf, adaSymbol, adaToken)

import qualified Codec.Serialise as Serialise
import qualified Data.ByteString.Lazy  as LBS
import qualified Data.ByteString.Short as SBS
import qualified Data.ByteString       as BS
import qualified Data.ByteString.Base16 as B16
import qualified Data.Text as T

import qualified Cardano.Api as C
import qualified Cardano.Api.Shelley as CS

-------------------------------------------------
-- DATUM & REDEEMER
-------------------------------------------------

data PreOrderDatum = PreOrderDatum
    { podFarmer     :: PubKeyHash
    , podBuyer      :: PubKeyHash
    , podAmount     :: Integer
    , podDelivered  :: Bool
    }
PlutusTx.unstableMakeIsData ''PreOrderDatum

data PreOrderAction
    = LockOrder
    | ConfirmDelivery
    | Withdraw
    | Refund
PlutusTx.unstableMakeIsData ''PreOrderAction

-------------------------------------------------
-- HELPERS
-------------------------------------------------

{-# INLINABLE signedBy #-}
signedBy :: PubKeyHash -> ScriptContext -> Bool
signedBy pkh ctx =
    txSignedBy (scriptContextTxInfo ctx) pkh

-------------------------------------------------
-- VALIDATOR
-------------------------------------------------

{-# INLINABLE mkPreOrderValidator #-}
mkPreOrderValidator :: PreOrderDatum -> PreOrderAction -> ScriptContext -> Bool
mkPreOrderValidator dat action ctx =
    case action of

        -------------------------------------------------
        -- Buyer locks ADA
        -------------------------------------------------
        LockOrder ->
            traceIfFalse "buyer not signed" buyerSigned

        -------------------------------------------------
        -- Buyer confirms delivery
        -------------------------------------------------
        ConfirmDelivery ->
            traceIfFalse "buyer not signed" buyerSigned &&
            traceIfFalse "already confirmed" (not $ podDelivered dat)

        -------------------------------------------------
        -- Farmer withdraws after confirmation
        -------------------------------------------------
        Withdraw ->
            traceIfFalse "farmer not signed" farmerSigned &&
            traceIfFalse "delivery not confirmed" (podDelivered dat) &&
            traceIfFalse "farmer not paid" farmerPaid

        -------------------------------------------------
        -- Buyer refund if not delivered
        -------------------------------------------------
        Refund ->
            traceIfFalse "buyer not signed" buyerSigned &&
            traceIfFalse "delivery already confirmed" (not $ podDelivered dat)

  where
    info :: TxInfo
    info = scriptContextTxInfo ctx

    buyerSigned :: Bool
    buyerSigned =
        signedBy (podBuyer dat) ctx

    farmerSigned :: Bool
    farmerSigned =
        signedBy (podFarmer dat) ctx

    farmerPaid :: Bool
    farmerPaid =
        valueOf
            (valuePaidTo info (podFarmer dat))
            adaSymbol
            adaToken >= podAmount dat

-------------------------------------------------
-- UNTYPED WRAPPER
-------------------------------------------------

{-# INLINABLE mkValidatorUntyped #-}
mkValidatorUntyped :: BuiltinData -> BuiltinData -> BuiltinData -> ()
mkValidatorUntyped d r c =
    if mkPreOrderValidator
        (unsafeFromBuiltinData d)
        (unsafeFromBuiltinData r)
        (unsafeFromBuiltinData c)
    then ()
    else error ()

validator :: Validator
validator =
    mkValidatorScript $$(PlutusTx.compile [|| mkValidatorUntyped ||])

-------------------------------------------------
-- SCRIPT ADDRESS
-------------------------------------------------

toBech32ScriptAddress :: C.NetworkId -> Validator -> String
toBech32ScriptAddress network val =
    let serialised = SBS.toShort . LBS.toStrict $ Serialise.serialise val
        plutusScript = CS.PlutusScriptSerialised serialised
        scriptHash   = C.hashScript (C.PlutusScript C.PlutusScriptV2 plutusScript)
        shelleyAddr :: C.AddressInEra C.BabbageEra
        shelleyAddr =
            C.makeShelleyAddressInEra
                network
                (C.PaymentCredentialByScript scriptHash)
                C.NoStakeAddress
    in T.unpack (C.serialiseAddress shelleyAddr)

-------------------------------------------------
-- FILE OUTPUT
-------------------------------------------------

writeValidator :: FilePath -> Validator -> IO ()
writeValidator path val = do
    LBS.writeFile path (Serialise.serialise val)
    putStrLn $ "Validator written to: " <> path

writeCBOR :: FilePath -> Validator -> IO ()
writeCBOR path val = do
    let bytes = LBS.toStrict (Serialise.serialise val)
    BS.writeFile path (B16.encode bytes)
    putStrLn $ "CBOR hex written to: " <> path

-------------------------------------------------
-- MAIN
-------------------------------------------------

main :: IO ()
main = do
    let network = C.Testnet (C.NetworkMagic 1)

    writeValidator "broiler_preorder_no_deadline.plutus" validator
    writeCBOR      "broiler_preorder_no_deadline.cbor"   validator

    putStrLn "Broiler Pre-Order (No Deadline) validator generated"
