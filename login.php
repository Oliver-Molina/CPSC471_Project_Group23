<?php
session_start();
include "db_connection.php";

$Email = $_POST['Email'];
$password = $_POST['Password'];

if(empty($Email)) {
    header("Location: index.php?error=User ID is required");
    exit();
}

else if(empty($password)) {
    header("Location: index.php?error=Password is required");
    exit();
}
include 'db_connection.php';
$user_query = $conn->prepare("SELECT * FROM project_manager.member AS user WHERE user.Email = ?");
$user_query->bind_param("s", $Email);
$user_query->execute();
$result = $user_query->get_result();
if(mysqli_num_rows($result) === 1) {
    $row = mysqli_fetch_assoc($result);

    if($row['Email'] == $Email && $row['Password'] == $password) {
        echo "Logged In!";
        $_SESSION['Email'] = $row['Email'];
        header("Location: ./homepage.php");
        exit();
    }
    else{
        header("Location: ./index.php?error=Incorrect Email or Password");
        exit();
    }
}
else {
    header("Location: ./index.php?error=Incorrect Email or Password");
    exit();
}
?>