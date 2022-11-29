<?php 
session_start();

if(isset($_SESSION['UserID'])){
    if(isset($_POST['projectID'])){
        $_SESSION['projectID'] = $_POST['projectID'];
    }
    else{
        header('Location: ./index.php?error=Invalid Project');
        exit();
    }
    ?>
    <!DOCTYPE html>
    <html>
    <head>
    <title>Project</title>
    </head>
    <body>
        <h1>This is the Project Page</h1>
        <p>Here you will access info on a specific project</p>
        <a href= './projects.php'>Back to Projects</a><br>
        <a href="./homepage.php">Homepage</a>
    </body>
    </html>
<?php
}
else{
    header('Location: ./index.php');
    exit();
}
?>
