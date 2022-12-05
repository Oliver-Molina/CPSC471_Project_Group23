<?php
session_start();
if(isset($_SESSION['Email'])){
    include 'db_connection.php';
    $query='SELECT Description FROM ORGANIZATION Where ID = ?';
    $user_query=$conn->prepare($query);
    $user_query->bind_param('s',$_SESSION['OrgID']);
    $user_query->execute();
    $result = $user_query->get_result();
    $row = mysqli_fetch_assoc($result);
    ?>
    <!DOCTYPE html>
    <html>
    <head>
        <title style="font-family:helvetica"> Homepage</title>
    </head>
    <body>
        <h1 style="font-family:helvetica">Homepage</h1>
        <h2 style="font-family:helvetica">Welcome to your homepage</h2>
        <p style="font-family:helvetica"><?php echo $row['Description'];?></p>
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