<?php 
session_start();
if(isset($_SESSION['username'])){
    if(isset($_POST['teamID'])){
        $_SESSION['teamID'] = $_POST['teamID'];
        echo $_SESSION['teamID'];
    }
    else{
        header('Location: ./index.php?error=Invalid Team');
        exit();
    }
    ?>

    <!DOCTYPE html>
    <html>

    <head>
    <title>Team</title>
    </head>

    <body>
        <h1>This is the Team Page</h1>
        <p>Here you will access info on a specific team</p>
        <a href= './teams.php'>Back to Teams</a><br>
        <a href="./homepage.php">Homepage</a><br>
    </body>
    </html>
<?php
}
else{
    header('Location: ./index.php');
    exit();
}
?>
