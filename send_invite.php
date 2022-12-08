<?php 
session_start();
include 'db_connection.php';
$email = $_POST['MemEmail'];
$eventID = $_POST['EventID'];
$sql = $conn->prepare('INSERT IGNORE INTO INVITATION(MEmail,EventID VALUES(?,?)');
$sql->bind_param('si',$email,$eventID);
$sql->execute();
header('Location: ./events.php');
exit();?>