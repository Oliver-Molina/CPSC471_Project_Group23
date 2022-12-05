<?php session_start();
if(isset($_SESSION['Email'])){
    
}
else{
    header('Location: ./index.php');
    exit();
}
?>