<?php
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);
if(isset($_SESSION['Email'])==false || isset($_SESSION['Admin'])==false){
    header('Location: ./index.php?Unauthorized');
    exit();
}
if(isset($_POST['MemEmail'])==false){
    header('Location: ./homepage.php');
    exit();
}
include 'db_connection.php';
echo $_POST['MemEmail'];
$str = 'INSERT IGNORE INTO ADMIN VALUES(?)';
$sql = $conn->prepare($str);
$sql->bind_param('s',$_POST['MemEmail']);
$sql->execute();
header('Location:./directory.php');
exit();
?>
