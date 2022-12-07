<?php 
session_start();
if (isset($_SESSION['Email'])) {
    include 'db_connection.php';
    $PName = $_POST['PName'];
    $EndDate = $_POST['EndDate'];
    $StartDate = $_POST['StartDate'];
    if (empty($PName) || empty($EndDate) || empty($EndDate) || empty($StartDate)) {
        header("Location: ./projects.php?error=Yikes");
    }
    while (mysqli_next_result($conn)) {
        ;
    }
    $insertion = 'INSERT INTO PROJECT(PName, StartDate, EndDate, OrgID) VALUES(?,?,?,?)';
    $insert_query = $conn->prepare($insertion);
    $insert_query->bind_param("ssss", $PName, $StartDate, $EndDate, $_SESSION['OrgID']);
    $insert_query->execute();
    
    header('Location: ./projects.php');
    exit();
}
else{
    session_unset();
    header('Location: ./index.php');
    exit();
}
?>
