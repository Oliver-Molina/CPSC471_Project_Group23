<?php 
session_start();
if(isset($_SESSION['username'])){
?>
    <!DOCTYPE html>
    <html>

    <head>
    <title>Events</title>
    </head>

    <body>
        <h1>This is the Events Page</h1>
        <p>Here you will access your Events</p>
        
        <a href="./homepage.php">homepage</a><br>
    </body>
    </html>
    <?php 
}
else{
    header("Location: index.php");
    exit();
}
?>
