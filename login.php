<?php
session_start();
include "db_connection.php";

$userID = $_POST['UserID'];
$password = $_POST['Password'];

if(empty($userID)) {
    header("Location: index.php?error=User ID is required");
    exit();
}

else if(empty($password)) {
    header("Location: index.php?error=Password is required");
    exit();
}
include 'db_connection.php';
$user_query = $conn->prepare("SELECT * FROM project_manager.member AS user WHERE user.ID = ?");
$user_query->bind_param("s", $userID);
$user_query->execute();
$result = $user_query->get_result();
if(mysqli_num_rows($result) === 1) {
    $row = mysqli_fetch_assoc($result);

    if($row['ID'] == $userID && $row['Password'] == $password) {
        echo "Logged In!";
        $_SESSION['UserID'] = $row['ID'];
        header("Location: ./homepage.php");
        exit();
    }
    else{
        header("Location: ./index.php?error=Incorrect UserID or Password");
        exit();
    }
}
else {
    header("Location: ./index.php?error=Incorrect UserID or Password");
    exit();
}
?>