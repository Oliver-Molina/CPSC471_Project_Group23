<?php
$dbhost = "localhost";
$dbuser = "root";
$dbpass = "";
$db = "project_manager";
$conn = new mysqli($dbhost, $dbuser, $dbpass,  $db) or die("Connect failed: %s\n". $conn -> error);
if(!$conn) {
    echo "Connection Failed";
}
return $conn;   
?>