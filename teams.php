<?php 
session_start();
if(isset($_SESSION['UserID'])){
    ?>

    <!DOCTYPE html>
    <html>

    <head>
    <title>Teams</title>
    </head>

    <body>
        <h1>This is the Teams Page</h1>
        <p>Here you will access your teams</p>
        <?php
        include 'db_connection.php';
        $user_query = $conn->prepare('SELECT * FROM available_food');
        $user_query->execute();
        $result = $user_query->get_result();
        while($row = mysqli_fetch_assoc($result)){
            ?>
            <form action="./team.php" id='team_submission' method='post'>
                <input type="hidden" name="TeamID" value='<?php echo $row['ID']?>'/>
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
    header('Location: ./index.php');
    exit();
}
?>
