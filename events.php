<?php 
session_start();error_reporting(E_ALL);
ini_set('display_errors', 1); 
if(isset($_SESSION['Email'])){
    if(isset($_SESSION['EventID'])){
        unset($_SESSION['EventID']);
    }
?>
    <!DOCTYPE html>
    <style>
       html,body{
            overflow-x:hidden;
           
            margin:0;
        }
        .header_block{
            margin: 0 -9999rem;
            /* add back negative margin value */
            padding: 0.25rem 9999rem;
            background-color:RGBA(98, 129, 208,100%);
        }
        button{
            font-size:16pt;
            text-align:center;
            height:50px;
            width:250px;
            background:RGBA(191, 216, 200,50%);
            border:solid #00916e 5px;
            color:#00916e;
            border-radius:30px
        }
        td{
            padding-top:6px;
            padding-bottom:6px;
            padding-left:12px;
            padding-right:12px;
        }
        .editor{
            font-size:16pt;
            text-align:center;
            height:50px;
            width:250px;
            background:RGBA(191, 216, 200,50%);
            border:solid #00916e 5px;
            color:#00916e;
            border-radius:30px
        }
        .gohome{
            background:RGBA(98, 129, 208,50%);
            text-align:center;
            font-family:helvetica;
            font-size:14pt;
            margin-left:300px;
            margin-top:75px;
            margin-right:300px;
            border-radius:30px;
            padding-top:10px;
            padding-bottom:10px;
            border:solid #274eb9 5px;
            color:#00916e;
        }
        .form_block{
            text-align:center;
            padding-top:10px;
        }
        table.center{
            background:rgba(186, 193, 184,60%);
            border:10px solid #bac1b8;
            border-radius:10px;
            margin-left:auto;
            margin-right:auto;
            margin-bottom:20px;
        }
        .creator{
            width: 30px;
            height: 10px;
        }
    </style>
    <html>
    <head>
    <title>Events</title>
    </head>
    <body>
        <div class='header_block'>
        <h1 style='font-family:helvetica;color:black;text-align:center'>Upcoming Events</h1>
        </div>
        <?php
        include 'db_connection.php';
        $str = "SELECT  event_.EventID, event_.EventName FROM event_ JOIN  
         organization on organization.ID =  event_.HostID
        JOIN member AS user ON user.OrgID =  organization.ID WHERE user.Email = ?";
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
            ?><table><h3 style='text-align:center;color:black;font-family:helvetica'>Select an Event to view more details</h3><table class ='center'><?php
            while($row = mysqli_fetch_assoc($result)){
                ?>
            <div class='form_block'>
                <tr>
                <td>
                    <form action="./event.php" id='event_submission' method='post'>
                        <input type="hidden" name="EventID" value='<?php echo $row['EventID']?>'/>
                        <button type="submit" name="Submit" value='Submit'><b><?php echo $row['EventName']?></b></button>
                    </form>
                </td>
            <?php if(isset($_SESSION['Admin'])){?>
                <td>
                    <form action="./edit_event.php" id='event_submission' method='post'>
                        <input type="hidden" name="EventID" value='<?php echo $row['EventID'];?>'/>
                        <button class='editor' type="submit" id='creator' name="Submit" value='Submit'>Edit this event</button>
                    </form>
                </td>
            </div>
            </body>
            <?php } ?>
            </tr><?php
            } ?></table> 

            <?php
            if(isset($_SESSION['Admin'])){
            ?>
            <form action='./create_event.php'method='post'>
                <div class='new_event_button' style='text-align:center'>
                    <button style='text-align:center;marign-top:15px; margin-left:auto;margin-right:auto;width:300px;height10px;font-size:14'type='submit' 
                    name='creator'valu='new_event'>Create an Event</button>
                 </div>
            </form>
            <?php
            }
            ?><div class='gohome'>
                <a href="./homepage.php">Homepage</a><br>
        </div><?php
        }
}else{
    session_unset();
    header("Location: ./index.php");
    exit();
}
?>
</html>