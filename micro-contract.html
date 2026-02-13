 <!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Broiler Pre-Order DApp</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: "Poppins", sans-serif;
}

body {
  background: linear-gradient(-45deg, #0f172a, #1e293b, #065f46, #0f172a);
  background-size: 400% 400%;
  animation: gradientBG 12s ease infinite;
  color: white;
  min-height: 100vh;
}

@keyframes gradientBG {
  0% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
  100% { background-position: 0% 50%; }
}

.container {
  max-width: 1400px;
  margin: auto;
  padding: 40px;
}

h1 {
  font-size: 42px;
  text-align: center;
  margin-bottom: 10px;
}

.subtitle {
  text-align: center;
  color: #94a3b8;
  margin-bottom: 40px;
}

.grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(380px, 1fr));
  gap: 30px;
}

.card {
  background: rgba(255, 255, 255, 0.05);
  backdrop-filter: blur(14px);
  padding: 30px;
  border-radius: 18px;
  box-shadow: 0 0 40px rgba(0,0,0,0.4);
  transition: 0.3s ease;
}

.card:hover {
  transform: translateY(-6px);
  box-shadow: 0 0 50px rgba(16,185,129,0.4);
}

.card h2 {
  margin-bottom: 20px;
  color: #10b981;
}

input {
  width: 100%;
  padding: 14px;
  margin-bottom: 15px;
  border-radius: 10px;
  border: none;
  outline: none;
  font-size: 14px;
}

button {
  width: 100%;
  padding: 14px;
  border: none;
  border-radius: 10px;
  font-weight: 600;
  font-size: 14px;
  cursor: pointer;
  transition: 0.3s ease;
}

.primary {
  background: #10b981;
  color: black;
}

.primary:hover {
  background: #059669;
}

.secondary {
  background: #f59e0b;
  color: black;
}

.secondary:hover {
  background: #d97706;
}

.danger {
  background: #ef4444;
}

.danger:hover {
  background: #dc2626;
}

.connect-btn {
  max-width: 300px;
  margin: 0 auto 40px auto;
  display: block;
}

.log {
  margin-top: 40px;
  padding: 20px;
  background: rgba(0,0,0,0.5);
  border-radius: 12px;
  min-height: 80px;
  font-size: 14px;
  color: #cbd5e1;
  white-space: pre-wrap;
}

footer {
  margin-top: 50px;
  text-align: center;
  font-size: 13px;
  color: #94a3b8;
}
</style>
</head>
<body>

<div class="container">

  <h1>🐔 Broiler Pre-Order DApp</h1>
  <div class="subtitle">
    Secure Farm-to-Buyer Smart Contract on Cardano
  </div>

  <button id="connect" class="primary connect-btn">
    Connect Wallet
  </button>

  <div class="grid">

    <div class="card">
      <h2>Lock Order (Buyer)</h2>
      <input id="farmer" placeholder="Farmer Address" />
      <input id="amount" placeholder="Amount (ADA)" />
      <button id="lock" class="primary">Lock ADA</button>
    </div>

    <div class="card">
      <h2>Confirm Delivery</h2>
      <button id="confirm" class="secondary">
        Confirm Delivery
      </button>
    </div>

    <div class="card">
      <h2>Withdraw (Farmer)</h2>
      <button id="withdraw" class="primary">
        Withdraw Payment
      </button>
    </div>

    <div class="card">
      <h2>Refund (Buyer)</h2>
      <button id="refund" class="danger">
        Refund ADA
      </button>
    </div>

  </div>

  <div class="log" id="log">
    System log...
  </div>

  <footer>
    Broiler Smart Contract · Plutus V2 · No Deadline Version
  </footer>

</div>

<script type="module">

import {
  Lucid,
  Blockfrost,
  Constr,
  Data,
} from "https://unpkg.com/lucid-cardano@0.10.11/web/mod.js";

/* ================================
   CONFIG
================================ */

const BLOCKFROST_URL =
  "https://cardano-preprod.blockfrost.io/api/v0";

const BLOCKFROST_KEY =
  "preprodYjRkHfcazNkL0xxG9C2RdUbUoTrG7wip";

const NETWORK = "Preprod";

/* ================================
   SCRIPT (REPLACE WITH YOUR CBOR)
================================ */

const SCRIPT_CBOR = "590c310100003232323233223322323232323232323232323232323322323232323232323232323233223232232323232232232325335323232533335002153355335330143500122002350032222003102d1335738921106275796572206e6f74207369676e65640002c153355335350032222001102c102d102d133573892111616c726561647920636f6e6669726d65640002c102c15335330143500122002350032222003102d13357389201106275796572206e6f74207369676e65640002c153355335330143500122002350032222003102d13357389201106275796572206e6f74207369676e65640002c153355335350032222001102c102d102d13357389211a64656c697665727920616c726561647920636f6e6669726d65640002c102c153355335330143500122002350032222004102d13357389201116661726d6572206e6f74207369676e65640002c153355335350032222001102d13357389211664656c6976657279206e6f7420636f6e6669726d65640002c15335333573466e20c8c0ac004ccd54c03c4800488cd54c050480048d400488cd540d4008cd54c05c480048d400488cd540e0008ccd40048cc0ed2000001223303c00200123303b00148000004cd54c050480048d400488cd540d4008ccd40048cd54c060480048d400488cd540e4008d5406800400488ccd5540540680080048cd54c060480048d400488cd540e4008d54064004004ccd55404005400800540bcc8c8d4004888888888888ccd54c0744800488d40088888d401088cd400894cd4ccd5cd19b8f017001044043133504500600810082008503d00a350022200235003222200435003222200202c02d102d13357389210f6661726d6572206e6f7420706169640002c102c102c3333573466e1cd55cea80224000466442466002006004646464646464646464646464646666ae68cdc39aab9d500c480008cccccccccccc88888888888848cccccccccccc00403403002c02802402001c01801401000c008cd4094098d5d0a80619a8128131aba1500b33502502735742a014666aa052eb940a0d5d0a804999aa814bae502835742a01066a04a0606ae85401cccd540a40c5d69aba150063232323333573466e1cd55cea801240004664424660020060046464646666ae68cdc39aab9d5002480008cc8848cc00400c008cd40edd69aba15002303c357426ae8940088c98c80f8cd5ce01f01f81e09aab9e5001137540026ae854008c8c8c8cccd5cd19b8735573aa004900011991091980080180119a81dbad35742a00460786ae84d5d1280111931901f19ab9c03e03f03c135573ca00226ea8004d5d09aba2500223263203a33573807407607026aae7940044dd50009aba1500533502575c6ae854010ccd540a40b48004d5d0a801999aa814bae200135742a004605e6ae84d5d1280111931901b19ab9c036037034135744a00226ae8940044d5d1280089aba25001135744a00226ae8940044d5d1280089aba25001135744a00226ae8940044d55cf280089baa00135742a008603e6ae84d5d1280211931901419ab9c0280290263333573466e1d4015200621222200223333573466e1d4019200421222200123333573466e1d401d200221222200423333573466e1d4021200021222200323263202a33573805405605004e04c04a6666ae68cdc39aab9d5009480008cccc888848cccc00401401000c008dd71aba15009375c6ae854020dd69aba150073024357426ae89401c8c98c8098cd5ce01301381208130b09aab9e50011375400226aae74dd500089aba25001135744a00226aae7940044dd5000888911199aa980209000a81199aa98038900091a8009119aa8140011aa804800999aa980209000911a80111299a999aa9807090009919a80811199a801910010010009a80091000891980091299a8010814880081311a80091198050010028030801899a813802001a81200099aa98038900091a800911919aa8148019800802990009aa81591299a80089aa8050019109a80111299a99806001004089111980100500209803001801190009aa8121108911299a800880111099802801199aa9803890008028020008890911180180208909111800802190009aa810910891299a8008a81091099a811180200119aa98030900080200091199ab9a3371e004002038036446a004444444444444a66a666aa601e2400266a02044a66a004420062002a02e4a66a666ae68cdc780700081401389a80c8008a80c002108140813190009aa80f1108911299a80089a80191000910999a802910011802001199aa98038900080280200089109198008018010919118011bac0013200135501d2233335573e0024a038466a03660086ae84008c00cd5d100100a919191999ab9a3370e6aae7540092000233221233001003002300c35742a004600a6ae84d5d1280111931900a19ab9c014015012135573ca00226ea80048c8c8c8c8cccd5cd19b8735573aa00890001199991110919998008028020018011919191999ab9a3370e6aae7540092000233221233001003002301535742a00466a01a0286ae84d5d1280111931900c99ab9c01901a017135573ca00226ea8004d5d0a802199aa8043ae500735742a0066464646666ae68cdc3a800a4008464244460040086ae84d55cf280191999ab9a3370ea0049001119091118008021bae357426aae7940108cccd5cd19b875003480008488800c8c98c806ccd5ce00d80e00c80c00b89aab9d5001137540026ae854008cd4025d71aba135744a004464c6402a66ae7005405804c4d5d1280089aba25001135573ca00226ea80044cd54005d73ad112232230023756002640026aa03444646666aae7c008940688cd4064cd5406cc018d55cea80118029aab9e500230043574400602626ae84004488c8c8cccd5cd19b875001480008d401cc014d5d09aab9e500323333573466e1d400920022500723263201233573802402602001e26aae7540044dd50008909118010018891000919191999ab9a3370ea002900311909111180200298039aba135573ca00646666ae68cdc3a8012400846424444600400a60126ae84d55cf280211999ab9a3370ea006900111909111180080298039aba135573ca00a46666ae68cdc3a8022400046424444600600a6eb8d5d09aab9e500623263201033573802002201c01a01801626aae7540044dd5000919191999ab9a3370e6aae7540092000233221233001003002300535742a0046eb4d5d09aba2500223263200c33573801801a01426aae7940044dd50009191999ab9a3370e6aae75400520002375c6ae84d55cf280111931900519ab9c00a00b00813754002464646464646666ae68cdc3a800a401842444444400646666ae68cdc3a8012401442444444400846666ae68cdc3a801a40104664424444444660020120106eb8d5d0a8029bad357426ae8940148cccd5cd19b875004480188cc8848888888cc008024020dd71aba15007375c6ae84d5d1280391999ab9a3370ea00a900211991091111111980300480418061aba15009375c6ae84d5d1280491999ab9a3370ea00c900111909111111180380418069aba135573ca01646666ae68cdc3a803a400046424444444600a010601c6ae84d55cf280611931900999ab9c01301401101000f00e00d00c00b135573aa00826aae79400c4d55cf280109aab9e5001137540024646464646666ae68cdc3a800a4004466644424466600200a0080066eb4d5d0a8021bad35742a0066eb4d5d09aba2500323333573466e1d4009200023212230020033008357426aae7940188c98c8030cd5ce00600680500489aab9d5003135744a00226aae7940044dd5000919191999ab9a3370ea002900111909118008019bae357426aae79400c8cccd5cd19b875002480008c8488c00800cdd71aba135573ca008464c6401266ae7002402801c0184d55cea80089baa00112232323333573466e1d400520042122200123333573466e1d40092002232122230030043006357426aae7940108cccd5cd19b87500348000848880088c98c8028cd5ce00500580400380309aab9d5001137540024646666ae68cdc3a800a4004401446666ae68cdc3a801240004014464c6400c66ae7001801c01000c4d55ce9baa001499240103505431001200132001355009223350014800088d4008894cd4ccd5cd19b8f00200d009008130070011300600332001355008223350014800088d4008894cd4ccd5cd19b8f00200c00800710011300600312200212200111220021221223300100400311221233001003002488100223370000400222464600200244660066004004003";

const script = {
  type: "PlutusV2",
  script: SCRIPT_CBOR,
};

/* ================================
   DATUM SCHEMA
================================ */

const PreOrderDatum = Data.Object({
  podFarmer: Data.Bytes(),
  podBuyer: Data.Bytes(),
  podAmount: Data.Integer(),
  podDelivered: Data.Boolean(),
});

/* ================================
   REDEEMERS
================================ */

const lockRedeemer    = Data.to(new Constr(0, []));
const confirmRedeemer = Data.to(new Constr(1, []));
const withdrawRedeemer= Data.to(new Constr(2, []));
const refundRedeemer  = Data.to(new Constr(3, []));

/* ================================
   GLOBAL STATE
================================ */

let lucid;
let walletAddress;
let walletPkh;
let scriptAddress;

/* ================================
   INIT
================================ */

async function init() {
  lucid = await Lucid.new(
    new Blockfrost(BLOCKFROST_URL, BLOCKFROST_KEY),
    NETWORK
  );

  const api = await window.cardano.lace.enable();
  lucid.selectWallet(api);

  walletAddress = await lucid.wallet.address();
  walletPkh =
    lucid.utils.getAddressDetails(walletAddress)
      .paymentCredential.hash;

  scriptAddress =
    lucid.utils.validatorToAddress(script);

  log("Connected: " + walletAddress);
}

/* ================================
   LOCK ORDER
================================ */

async function lockOrder() {

  const farmerAddr =
    document.getElementById("farmer").value;

  const farmer =
    lucid.utils.getAddressDetails(farmerAddr)
      .paymentCredential.hash;

  const amount =
    BigInt(document.getElementById("amount").value)
    * 1_000_000n;

  const datum = Data.to(
    {
      podFarmer: farmer,
      podBuyer: walletPkh,
      podAmount: amount,
      podDelivered: false,
    },
    PreOrderDatum
  );

  const tx = await lucid
    .newTx()
    .payToContract(
      scriptAddress,
      { inline: datum },
      { lovelace: amount }
    )
    .addSignerKey(walletPkh)
    .complete();

  const signed = await tx.sign().complete();
  const txHash = await signed.submit();

  log("Order Locked: " + txHash);
}

/* ================================
   CONFIRM DELIVERY
================================ */

async function confirmDelivery() {

  const utxos = await lucid.utxosAt(scriptAddress);
  const utxo = utxos[0];

  const tx = await lucid
    .newTx()
    .collectFrom([utxo], confirmRedeemer)
    .attachSpendingValidator(script)
    .addSignerKey(walletPkh)
    .complete();

  const signed = await tx.sign().complete();
  const txHash = await signed.submit();

  log("Delivery Confirmed: " + txHash);
}

/* ================================
   WITHDRAW
================================ */

async function withdraw() {

  const utxos = await lucid.utxosAt(scriptAddress);
  const utxo = utxos[0];

  const tx = await lucid
    .newTx()
    .collectFrom([utxo], withdrawRedeemer)
    .attachSpendingValidator(script)
    .addSignerKey(walletPkh)
    .complete();

  const signed = await tx.sign().complete();
  const txHash = await signed.submit();

  log("Withdraw Success: " + txHash);
}

/* ================================
   REFUND
================================ */

async function refund() {

  const utxos = await lucid.utxosAt(scriptAddress);
  const utxo = utxos[0];

  const tx = await lucid
    .newTx()
    .collectFrom([utxo], refundRedeemer)
    .attachSpendingValidator(script)
    .addSignerKey(walletPkh)
    .complete();

  const signed = await tx.sign().complete();
  const txHash = await signed.submit();

  log("Refund Success: " + txHash);
}

/* ================================
   UI
================================ */

function log(msg) {
  document.getElementById("log").innerText = msg;
}

document.getElementById("connect").onclick = init;
document.getElementById("lock").onclick    = lockOrder;
document.getElementById("confirm").onclick = confirmDelivery;
document.getElementById("withdraw").onclick= withdraw;
document.getElementById("refund").onclick  = refund;

</script>

</body>
</html>
