<?php
require "lib/Braintree.php";

// Get your keys by logging into your Braintree Merchant/Sandbox account
Braintree_Configuration::environment('sandbox');
Braintree_Configuration::merchantId('merchantId');
Braintree_Configuration::publicKey('publicKey');
Braintree_Configuration::privateKey('privateKey');

$clientToken = Braintree_ClientToken::generate();

header('Content-Type: application/json');
echo json_encode(["client_token" => $clientToken])
?>