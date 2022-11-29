<?php 
session_start();
if(isset($_SESSION['Email'])){
?>
    <!DOCTYPE html>
    <html>

    <head>
    <title>Events</title>
    </head>

    <body>
        <h1>This is the Events Page</h1>
        <p>Here you will access your Events</p>
        <?php
        include 'db_connection.php';
        $user_query = $conn->prepare('SELECT * FROM available_food');
        $user_query->execute();
        $result = $user_query->get_result();
        while($row = mysqli_fetch_assoc($result)){
            ?>
            <form action="./event.php" id='event_submission' method='post'>
                <input type="hidden" name="EventID" value='<?php echo $row['EventID']?>'/>
                <button type="submit" name="Submit" value='Submit'><?php echo $row['EventName']?></button>
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
    header("Location: ./index.php");
    exit();
}
?>
