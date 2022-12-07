<?php
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);
if(isset($_SESSION['Email'])){
    if(isset($_SESSION['EventID'])){
        unset($_SESSION['EventID']);
    }
    include 'db_connection.php';
    $query='SELECT * FROM ORGANIZATION Where ID = ?';
    $user_query=$conn->prepare($query);
    $user_query->bind_param('s',$_SESSION['OrgID']);
    $user_query->execute();
    $result = $user_query->get_result();
    $row = mysqli_fetch_assoc($result);
    $query2='SELECT Fname, Lname FROM MEMBER WHERE Email = ?';
    $user_query2=$conn->prepare($query2);
    $user_query2->bind_param('s',$_SESSION['Email']);
    $user_query2->execute();
    $result2=$user_query2->get_result();
    $row2=mysqli_fetch_assoc($result2);
    $query3='SELECT * FROM ADMIN WHERE Email = ?';
    $admin_check = $conn->prepare($query3);
    $admin_check->bind_param('s', $_SESSION['Email']);
    $admin_check->execute();
    $result3=$admin_check->get_result();
    if(mysqli_num_rows($result3)==1){
        $_SESSION['Admin']='Yes';
    }
    ?>
    <!DOCTYPE html>
    <html>
    <head>
        <title style="font-family:helvetica"> Homepage</title>
    </head>
    <body>
        <h1 style="font-family:helvetica">Homepage for <?php echo $row['OrgName']?> </h1>
        <h2 style="font-family:helvetica">Welcome to your homepage, <?php echo $row2['Fname'];?> <?php echo $row2['Lname'];?>!</h2>
        <p style="font-family:helvetica"><?php echo $_SESSION['OrgID'];?></p>
        <p style="font-family:helvetica"><?php echo $row['Description'];?></p>
        <p style="font-family:helvetica;font-size:large"> <a href="./events.php">Events</a><br>
        <a href="./projects.php">Projects</a><br>
        <a href="./teams.php">Teams</a><br>
        <a href="./inventory.php">Inventory</a><br>
        <a href="./directory.php">Organization Directory</a><br>
        <a href="./logout.php">Logout</a><br></p>
    </body>
    
    </html>
    <?php 
}
else{
    session_unset();
    header("Location: ./index.php");
    exit();
}
?>