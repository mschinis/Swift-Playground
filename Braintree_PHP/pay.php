<?php
/* Pay file */
include "lib/Braintree.php";

// Get your keys by logging into your Braintree Merchant/Sandbox account
Braintree_Configuration::environment('sandbox');
Braintree_Configuration::merchantId('merchantId');
Braintree_Configuration::publicKey('publicKey');
Braintree_Configuration::privateKey('privateKey');

$payment_method_nonce = $_POST["payment_method_nonce"];

$result = Braintree_Transaction::sale(array(
  'amount' => '10.00',
  'paymentMethodNonce' => $payment_method_nonce
));

header('Content-Type: application/json');
echo json_encode($result);