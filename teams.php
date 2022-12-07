<?php 
session_start();
if(isset($_SESSION['Email'])){

?>
<!DOCTYPE html>
<html>
<head>
<title>Teams</title>
</head>
<style>
    .button{
        width:30px;
    }
</style>
<body>
    <h1>This is the Teams Page</h1>
    <p>Here you will access your teams</p>
    <?php
        include 'db_connection.php';

        $isAdmin_Query->execute();
        if($row = mysqli_fetch_assoc($isAdmin_Query->get_result())){
            ?>
            <p><strong>Create a new team</strong></p>
            <form action="./create_new_team.php" id='team_creation' method='post'>
                <button type="submit" name="Submit" value='Submit'>Create a new Team</button>
            </form>
            <?php
        }
        ?><p><strong>My Teams</strong></p><?php
        $query = 'SELECT TEAM.ID, TEAM.TName FROM TEAM JOIN BELONGS ON Team.ID = BELONGS.Team_ID 
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
            <form action="./team.php" id='team_submission' method='post'>
                <input type="hidden" name="teamID" value='<?php echo $row['ID']?>'/>
                <button type="submit" name="Submit" value='Submit'><?php echo $row['TName']?></button>
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