<?php
$dbhost = "localhost";
$dbuser = "root";
$dbpass = "";
$db = "project_manager";
$conn = new mysqli($dbhost, $dbuser, $dbpass,  $db) or die("Connect failed: %s\n". $conn -> error);
if(!$conn) {
    echo "Connection Failed";
}


$isAdmin = 'SELECT * FROM ADMIN AS A WHERE A.Email = ?';
$isAdmin_Query = $conn->prepare($isAdmin);
$isAdmin_Query->bind_param('s', $_SESSION['Email']);
return $conn;   
?>