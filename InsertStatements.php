<?php
session_start();
include 'db_connection.php';
if(isset($_SESSION['Email'])){
    $str = "SELECT * FROM project_manager.EVENT AS E JOIN  
    project_manager.INVITED AS I ON E.EventID = I.EventID 
    JOIN project_manager.MEMBER AS M ON I.MEmail = M.Email 
    WHERE M.Email = ?";

    $user_query = $conn->prepare("SELECT * FROM project_manager.`EVENT` INNER JOIN project_manager.`INVITED AS user WHERE user.Email = ?");
    $user_query->bind_param("s", $Email);
    $user_query->execute();
    $result = $user_query->get_result();


}

?>