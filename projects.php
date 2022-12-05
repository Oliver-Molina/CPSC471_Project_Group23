<?php 
session_start();
if(isset($_SESSION['Email'])){

?>
<!DOCTYPE html>
<html>
<head>
<title>Projects</title>
</head>
<style>
    .button{
        width:30px;
    }
</style>
<body>
    <h1>This is the Projects Page</h1>
    <p>Here you will access your projects</p>
    <?php
        include 'db_connection.php';

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
        $query = 'SELECT PROJECT.ID, PROJECT.PName FROM PROJECT JOIN TEAM ON Project.ID = TEAM.ProjectID
        JOIN BELONGS ON Team.ID = BELONGS.Team_ID 
        WHERE BELONGS.MEmail = ?';
        $user_query = $conn->prepare($query);
        $user_query->bind_param('s',$_SESSION['Email']);
        $user_query->execute();
        $result = $user_query->get_result();
        if(mysqli_num_rows($result) == 0){
            ?>
            <html>
                <p style="font-family:helvetica;text-align:center">You currently have no projects</p>
            </html>
        <?php
        }
        while($row = mysqli_fetch_assoc($result)){
            ?>
            <form action="./project.php" id='project_submission' method='post'>
                <input type="hidden" name="projectID" value='<?php echo $row['ID']?>'/>
                <button type="submit" name="Submit" value='Submit'><?php echo $row['PName']?></button>
            </form>
            <?php
        }
    ?>
    <a href="./homepage.php">homepage</a><br>
</body>
</html>
<?php 
}
else{
    session_unset();
    header('Location: ./index.php?');
    exit();
}
?>