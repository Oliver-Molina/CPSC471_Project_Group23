<?php 
session_start();
if(isset($_SESSION['Email'])){
?>
    <!DOCTYPE html>
    <style>
        button{
            text-align:center;
            height:30px;
            width:100px;
        }
        .form_block{
            text-align:center;
            padding-top:20px;
        }
    </style>
    <html>
    <head>
    <title>Events</title>
    </head>
    <body>
        <h1 style='font-family:helvetica;color:tomato;text-align:center;padding-bottom:20px'>This is the Events Page</h1>
        <p style="padding-left:100px">Here you will access your Events</p>
        <?php
        include 'db_connection.php';
        $str = "SELECT  event_.EventID, event_.EventName FROM event_ JOIN  
         organization on organization.ID =  event_.HostID
        JOIN  member AS user ON user.OrgID =  organization.ID WHERE user.Email = ?";
        $user_query = $conn->prepare($str);
        $user_query->bind_param("s", $_SESSION['Email']);
        $user_query->execute();
        $result = $user_query->get_result();
        if(empty($result)){
            ?>
            <h3>It looks like you don't have any events.</h3>
            <?php
        }
        else{
            while($row = mysqli_fetch_assoc($result)){
                ?>
            <div class='form_block'>
                <form action="./event.php" id='event_submission' method='post'>
                    <input type="hidden" name="EventID" value='<?php echo $row['EventID']?>'/>
                    <button type="submit" name="Submit" value='Submit'><?php echo $row['EventName']?></button>
                </form>
            </div>
                <?php
            }
        }
    ?>
        <a href="./homepage.php">homepage</a><br>
    </body>
    </html>
    <?php 
}
else{
    session_unset();
    header("Location: ./index.php");
    exit();
}
?>