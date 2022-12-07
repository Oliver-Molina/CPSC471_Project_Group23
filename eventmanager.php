<?php 
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);
if(isset($_SESSION['Email'])){
    if(isset($_POST['EventID']) == false){
        header('Location: ./index.php?Invalid Event');
        exit();
    }
    else if(isset($_SESSION['Admin']) == false){
        header('Location ./index.php?unauthorized');
        exit();
    }
    include 'db_connection.php'; 
    $event = $_POST['EventID'];
    
    #this is what handles deleting events
}
else{
    session_unset();
    header('Location: ./index.php');
    exit();
}
?>
