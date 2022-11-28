<?php
session_start();

if(isset($_SESSION['username'])){
    ?>
    <!DOCTYPE html>
    <html>
    <head>
        <title>Homepage</title>
    </head>
    <body>
        <h1>Welcome to your homepage</h1>
        <p>This page will display your options for accessing org website info.</p>
        <?php
        include 'db_connection.php';
        ?>
        <a href="./events.php">Events</a><br>
        <a href="./projects.php">Projects</a><br>
        <a href="./teams.php">Teams</a><br>
        <a href="./inventory.php">Inventory</a><br>
        <a href="./logout.php">Logout</a><br>
    </body>
    </html>
    <?php 
}
else{
    header("Location: ./index.php");
    exit();
}
?>