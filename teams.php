<?php 
session_start();
if(isset($_SESSION['username'])){
    ?>

    <!DOCTYPE html>
    <html>

    <head>
    <title>Teams</title>
    </head>

    <body>
        <h1>This is the Teams Page</h1>
        <p>Here you will access your teams</p>
        <a href="./homepage.php">homepage</a><br>
    </body>
    </html>
<?php
}
else{
    header('Location: index.php');
    exit();
}
?>
