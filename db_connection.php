<?php

function OpenCon()
 {
 $dbhost = "localhost";
 $dbuser = "";
 $dbpass = "";
 $db = "food_inventory";

try {
    $conn = new mysqli($dbhost, $dbuser, $dbpass,$db) or die("Connect failed: %s\n". $conn -> error);
    return $conn;
    //code...
} catch (Exception $e) {
    return $e->getMessage();
    //throw $th;
}

 }
 
function CloseCon($conn)
 {
 $conn -> close();
 }
   
?>