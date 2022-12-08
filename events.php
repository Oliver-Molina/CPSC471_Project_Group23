<?php 
session_start();
if(isset($_SESSION['Email'])){
    if(isset($_SESSION['EventID'])){
        unset($_SESSION['EventID']);
    }
?>
    <!DOCTYPE html>
    <style>
       html{
            background-color:#5DADE2;
        }
        button{
            font-size:16pt;
            text-align:center;
            height:50pxpx;
            width:250px;
            background:white;
            border:outset black 1px;
            border-radius:30px
        }
        td{
            padding-top:6px;
            padding-bottom:6px;
            padding-left:12px;
            padding-right:12px;
        }
        .form_block{
            text-align:center;
            padding-top:20px;
        }
        table.center{
            background:#5DADE2;
            border-radius:10px;
            margin-left:auto;
            margin-right:auto;
        }
    </style>
    <html>
    <head>
    <title>Events</title>
    </head>
    <body>
        <h1 style='font-family:helvetica;color:white;text-align:center;padding-bottom:20px'>This is the Events Page</h1>
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
            ?><table class ='center'><?php
            while($row = mysqli_fetch_assoc($result)){
                ?>
            <div class='form_block'>
                <tr>
                <td>
                    <form action="./event.php" id='event_submission' method='post'>
                        <input type="hidden" name="EventID" value='<?php echo $row['EventID']?>'/>
                        <button type="submit" name="Submit" value='Submit'><?php echo $row['EventName']?></button>
                    </form>
                </td>
            <?php if(isset($_SESSION['Admin'])){?>
                <td>
                    <form action="./edit_event.php" id='event_submission' method='post'>
                        <input type="hidden" name="EventID" value='<?php echo $row['EventID'];?>'/>
                        <button type="submit" name="Submit" value='Submit'>Edit this event</button>
                    </form>
                </td>
            </div>
            </body>
            <?php } ?>
            </tr><?php
            } ?></table> 
            <a href='./create_event.php'>Create an Event</a>
            <?php
        }
}else{
    session_unset();
    header("Location: ./index.php");
    exit();
}
?><a href="./homepage.php">homepage</a><br>
</html>