<?php 
session_start();
if(isset($_SESSION['Email'])){
include 'db_connection.php';
// Get user's projects
$projects_query = $conn->prepare(
    'SELECT P.ID, P.PName
    FROM PROJECT AS P 
    WHERE EXISTS(
        SELECT*
        FROM TEAM AS T
        JOIN BELONGS AS B ON(T.ID = B.Team_ID)
        WHERE(B.MEmail = ?
            AND T.ProjectID = P.ID)
    )');
$projects_query->bind_param("s", $_SESSION['Email']);
?>


<!DOCTYPE html>
<html>

<head>
<title>Projects</title>
</head>

<body>
    <h1>Projects Page</h1>
    <?php
        $isAdmin_Query->execute();
        if($row = mysqli_fetch_assoc($isAdmin_Query->get_result())){
            ?>
            <p><strong>Create a new project</strong></p>
            <form action="./new_project.php" id='project_creation' method='post'>
                <button type="submit" name="Submit" value='Submit'>Create a new Project</button>
            </form>
            <?php
        }
        ?><p><strong>My Projects</strong></p><?php
        $projects_query->execute();
        $result = $projects_query->get_result();
        while($row = mysqli_fetch_assoc($result)){
            ?>
            <div>
                <form action="./project.php" id='project_submission' method='post'>
                    <input type="hidden" name="projectID" value='<?php echo $row['ID']?>'/>
                    <button type="submit" name="Submit" value='Submit'><?php echo $row['PName']?></button>
                </form>
            </div>
            
            <?php
        }
    ?>
    </br>
    <a href="./homepage.php">homepage</a><br>
</body>
</html>
<?php 
}
else{
    header('Location: ./index.php?');
    exit();
}
?>