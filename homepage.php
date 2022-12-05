<?php
session_start();
if(isset($_SESSION['Email'])){
    ?>
    <!DOCTYPE html>
    <html>
    <head>
        <title style="font-family:helvetica"> Homepage</title>
    </head>
    <body>
        <h1 style="font-family:helvetica">Homepage</h1>
        <h2 style="font-family:helvetica">Welcome to your homepage</h2>
        <p style="font-family:helvetica">This page will display your options for accessing org website info.</p>
        <p style="font-family:helvetica;font-size:large"> <a href="./events.php">Events</a><br>
        <a href="./projects.php">Projects</a><br>
        <a href="./teams.php">Teams</a><br>
        <a href="./inventory.php">Inventory</a><br>
        <a href="./logout.php">Logout</a><br></p>
    </body>
    
    </html>
    <?php 
}
else{
    header("Location: ./index.php");
    exit();
}
?>