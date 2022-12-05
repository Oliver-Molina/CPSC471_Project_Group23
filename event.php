<?php 
session_start();
if(isset($_SESSION['Email'])){
    if(isset($_POST['EventID'])){
        $_SESSION['EventID'] = $_POST['EventID'];
        echo $_SESSION['EventID'];
    }
    else{
        header('Location: ./index.php?Invalid Event');
        exit();
    }
    ?>

    <!DOCTYPE html>
    <html>

    <head>
    <title>Event</title>
    </head>

    <body>
        <h1>This is the Event Page</h1>
        <p>Here you will access info on a specific event</p>
        <a href= './events.php'>Back to Events</a><br>
        <a href="./homepage.php">Homepage</a><br>
    </body>
    </html>
<?php
}
else{
    session_unset();
    header('Location: ./index.php');
    exit();
}
?>
