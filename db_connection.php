<?php
$dbhost = "localhost";
$dbuser = "root";
$dbpass = "";
$db = "food_inventory";
$conn = new mysqli($dbhost, $dbuser, $dbpass,  $db) or die("Connect failed: %s\n". $conn -> error);
if(!$conn) {
    echo "Connection Failed";
}
return $conn;   
?>