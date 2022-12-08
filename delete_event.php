<?php
session_start();
if(isset($_POST['EventID'])==false){
    header('Location: ./homepage.php');
    exit();
}
include 'db_connection.php';
$sql = 'DELETE FROM EVENT_ WHERE EventID = ?';
$query = $conn->prepare($sql);
$query->bind_param('i',$_POST['EventID']);
$query->execute();
header('Location: ./events.php?success');
exit();
?>
