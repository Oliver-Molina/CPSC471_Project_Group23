<?php 
session_start();
if(isset($_SESSION['Email'])){
    if(!isset($_SESSION['projectID']) || !isset($_POST['PName'],$_POST['EndDate'])){
        header("Location: ./project.php?error=Something Went Wrong");
        exit();
    }
    $projectID = $_SESSION['projectID'];
    include 'db_connection.php';  


    $edit_project = 
    "UPDATE PROJECT
    SET PName = ?,
    EndDate = ?
    WHERE ID = ?
    AND orgID = ?";

    $edit_project_query = $conn->prepare($edit_project);
    $edit_project_query->bind_param("ssis", $_POST['PName'], $_POST['EndDate'], $_SESSION['projectID'], $_SESSION['OrgID']);
    $edit_project_query->execute();

    header('Location: ./projects.php');
    exit();
}
else{
    session_unset();
    header('Location: ./index.php');
    exit();
}
?>
