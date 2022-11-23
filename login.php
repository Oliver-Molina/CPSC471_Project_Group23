<?php
session_start();
include "db_connection.php";

$username = $_POST['username'];
$password = $_POST['password'];

if(empty($username)) {
    header("Location: index.php?errno=Username is required");
    exit();
}

else if(empty($password)) {
    header("Location: index.php?errno=Password is required");
    exit();
}
include 'db_connection.php';
$user_query = $conn->prepare("SELECT * FROM food_inventory.daily_client_needs AS user WHERE user.Client = ?");
$user_query->bind_param("s", $username);
$user_query->execute();
$result = $user_query->get_result();
if(mysqli_num_rows($result) === 1) {
    $row = mysqli_fetch_assoc($result);
    #echo $row['Client'];
    #echo $row['ClientID'];
    #echo $username;
    #echo $password;

    if($row['Client'] == $username && $row['ClientID'] == $password) {
        echo "Logged In!";
        $_SESSION['username'] = $row['Client'];
        unset($_SESSION['password']);
        header("Location: homepage.php");
        exit();
    }
    else{
        header("Location: index.php?errno=Incorrect Username or Password");
        exit();
    }
}
else {
    header("Location: index.php?errno=Incorrect Username or Password");
    exit();
}
?>