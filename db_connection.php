<?php
$dbhost = "localhost";
$dbuser = "oliver";
$dbpass = "OM#2221@MySQL";
$db = "food_inventory";
$conn = new mysqli($dbhost, $dbuser, $dbpass,$db) or die("Connect failed: %s\n". $conn -> error);
if(!$conn) {
    echo "Connection Failed";
}
return $conn;   
?>