<?php
$dbhost = "localhost";
$dbuser = "root";
$dbpass = "";
$db = "project_manager";
$conn = new mysqli($dbhost, $dbuser, $dbpass,  $db) or die("Connect failed: %s\n". $conn -> error);
if(!$conn) {
    echo "Connection Failed";
}

// Find if a user is an admin
$isAdmin_Query = $conn->prepare(
'SELECT*
FROM ADMIN AS a
WHERE a.Email = ?'
);
$isAdmin_Query->bind_param("s", $_SESSION['Email']);
    
return $conn;   
?>