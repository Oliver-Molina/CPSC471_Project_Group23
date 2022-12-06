<?php session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);
include 'db_connection.php';
$email = $_POST['Email'];
$orgid = $_POST['OrgID'];
$gender= $_POST['Gender'];
$fname=$_POST['Fname'];
$lname=$_POST['Lname'];
$password = $_POST['Password'];
$password2 = $_POST['Password2'];
if(empty($email)){
    header("Location: ./registration.php?error=An email is required");
    exit();
}
else if(empty($orgid)){
    header('Location: ./registration.php?error=Organization is required');
    exit();
}
else if(empty($fname)){
    header("Location: ./registration.php?error=First Name is missing");
    exit();
}
else if(empty($lname)){
    header("Location: ./registration.php?error=Last Name is missing");
    exit();
}
else if(empty($password)){
    header("Location: ./registration.php?error=OrgID invalid");
    exit();
}
else if(empty($password2)){
    header("Location: ./registration.php?error=Password must be confirmed");
    exit();
}
else if($password != $password2){
    header("Location: ./registration.php?error=Passwords do not match");
    exit();
}
else{
    $query = 'SELECT Email FROM MEMBER AS user WHERE user.Email = ?';
    $email_query = $conn->prepare($query);
    $email_query->bind_param('s',$email);
    $email_query->execute();
    $result = $email_query->get_result();
    if(mysqli_num_rows($result)!=0){
        header("Location: ./registration.php?error=User already exists");
        exit();
    }
    $query2 = 'SELECT ID FROM `ORGANIZATION` WHERE ID = ?';
    $email_query2 = $conn->prepare($query2);
    $email_query2->bind_param('s',$orgid);
    $email_query2->execute();
    $result2 = $email_query2->get_result();
    if(mysqli_num_rows($result2)==0){
        header("Location: ./registration.php?error=OrgID invalid");
        exit();
    }
    $query3 = 'INSERT INTO MEMBER (Fname, Lname, Gender, Email, OrgID, Password) VALUES (?,?,?,?,?,?)';
    $insert = $conn->prepare($query3);
    $insert->bind_param('ssssss',$fname,$lname,$gender,$email,$orgid,$password);
    if($insert->execute()){
        echo 'Success';
    }
    else{
        echo 'Failed';
    }

    $_SESSION['Email']=$email;
    $_SESSION['OrgID']=$orgid;
    header("Location: ./homepage.php");
    exit();
}
?>