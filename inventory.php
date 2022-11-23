<?php 
session_start();
if(isset($_SESSION['username'])){
?>
    <!DOCTYPE html>
    <html>

    <head>
    <title>Inventory</title>
    </head>

    <body>
        <h1>This is the Inventory Page</h1>
        <p>Here you will access your Inventory</p>
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

