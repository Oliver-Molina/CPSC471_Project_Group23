<?php 
session_start();

if(isset($_SESSION['Email'])){
    if(isset($_POST['projectID'])){
        $_SESSION['projectID'] = $_POST['projectID'];
    }
    else{
        header('Location: ./index.php?error=Invalid Project');
        exit();
    }
    include "db_connection.php";
    // Get Project Information
    $project_info_query = $conn->prepare(
        'SELECT*
        FROM PROJECT AS P
        WHERE(P.ID = ?)'
    );
    $project_info_query->bind_param("s", $_POST['projectID']);
    $project_info_query->execute();
    $project_info = mysqli_fetch_assoc($project_info_query->get_result());
    ?>
    <!DOCTYPE html>
    <html>
    <head>
    <title>Project</title>
    </head>
    <body>
        <h1><?php echo $project_info['PName']?></h1>
        <p><strong>Project Information</strong></p>
        <?php
            echo "<strong>StartDate: </strong>",$project_info['StartDate'],"</br><strong>EndDate: </strong>",$project_info['EndDate'];
        ?>
        </br>
        <a href= './projects.php'>Back to Projects</a><br>
        <a href="./homepage.php">Homepage</a>
    </body>
    </html>
<?php
}
else{
    session_unset();
    header('Location: ./index.php');
    exit();
}
?>
