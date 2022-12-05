<?php 
session_start();
if(isset($_SESSION['Email'])){
    include 'db_connection.php';
    $isAdmin_Query->execute();
    $PName = $_POST['PName'];
    $EndDate = $_POST['EndDate'];
    if(empty($PName) || empty($EndDate)){
        header("Location: ./projects.php?error=Yikes");
    }
    //do sql shit here
}
else{
    session_unset();
    header('Location: ./index.php');
    exit();
}
?>