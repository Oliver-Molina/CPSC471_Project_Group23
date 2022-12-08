<?php 
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);
if(isset($_SESSION['Email'])){
    if(isset($_SESSION['EventID'])){
        $_POST['EventID'] = $_SESSION['EventID'];
    }
    if(isset($_POST['EventID']) == false){
        header('Location: ./index.php?Invalid Event');
        exit();
    }
    else if(isset($_SESSION['Admin']) == false){
        header('Location ./index.php?unauthorized');
        exit();
    }
    include 'db_connection.php';  
    ?>
    <!DOCTYPE html>
    <style>
        html{
           background-color:white:
        }
        textarea{
            min-width:200px;
            min-height:100px;
            max-width:300px;
            max-height:100px;
        }
        label{
            padding-left:4px;
        }
        input{
            border-radius:3px;
            border:solid black 1px;
            margin-bottom:20px;
        }
        h1{
            font-family:helvetica;
            text-align:center;
            color:green;
        }
        .container{
            display:grid;
            position:static;
            height:600px;
            margin-top:10px;
            margin-left:10px;
            margin-right:10px;
            background-color:white;
            font-family:helvetica;
            left:5%;
            right:5%;
            border:3px solid black;
            border-radius:30px;
        }
        .address_block{
            grid-column-start:1;
            grid-column-end:2;
            padding-left:30px;
            font-family:helvetica;
        }
        .subcontainer{
            text-align:center;
            grid-column-start:1;
            grid-column-end:2;
            display:inline-grid;
            border-top:1px solid black;
            border-bottom:1px solid black;
        }
        .logistics{
            grid-column-start:3;
            grid-column-end:5;
            font-family:helvetica;
            border-left:1px solid black;
            padding-left:30px;
        }
        .start_block{
            grid-column-start:1;
            grid-column-end:2;
            padding-top:15px;
            border-right:1px solid black;
            border-left:1px solid black;
            border-bottom:1px solid;
            font-family:helvetica;
            font-size:12pt;
        }
        .end_block{
            grid-column-start:2;
            grid-column-end:3;
            padding-top:15px;
            border-right:1px solid black;
            font-family:helvetica;
            font-size:12pt;
        }
        .button{
            width:20px;
            padding-top:10px;
            font-size:14pt;
        }
        .deleter{
            background-color:tomato;
            border:1px solid black;
            border-radius:30px;
        }
        .save{
            background-color:rgba(46, 204, 113,40);
            border:1px solid black;
            border-radius:30px;
            color:black;
        }
        table.middle{
            margin-left:auto;
            margin-right:auto;
        }
       .block{
            text-align:center;
            grid-column-start:1;
            grid-column-end:5;
            padding-top:10x;
       }
    </style>                 
    <html>
    <head>
    <title>Edit Event</title>
    </head>
    <body>
        <h1>Event <?php  echo $_POST['EventID'];?></h3>
        <p>Here you will access info on a specific event</p>
        <a href= './events.php'>Back to Events</a><br>
        <a href="./homepage.php">Homepage</a><br>
  
<?php
    $sql = 'SELECT EventName, No_Attendees, Description, StartDateTime, EndDateTime, EVENT_USES.BuildingID,
    BName, BNo, StName, City, ProvStTr, Country, EVENT_USES.BuildingID FROM EVENT_ JOIN EVENT_USES 
    ON EVENT_.EventID = EVENT_USES.EventID
    JOIN BUILDING ON EVENT_USES.BuildingID = BUILDING.ID
    WHERE EVENT_.EventID = ?';
    $query = $conn -> prepare($sql);
    $query->bind_param('i',$_POST['EventID']);
    $query->execute();
    $result=$query->get_result();
    $row=mysqli_fetch_assoc($result);
    $sql2 = 'SELECT * FROM MEMBER WHERE OrgID = ?';
    $query4 = $conn->prepare($sql2);
    $query4->bind_param('s',$_SESSION['OrgID']);
    $query4->execute();
    $result4 = $query4->get_result();?>
    <form action='./eventmanager.php' method='post'>
    <div class='container'>
    <div class='address_block' id='a'>
        <h2 style='text-align:center'>Location Information</h2>
        <h3>Address:</h3>
        <label>Building Name</label>
        <input type='text' name = 'bname' id='bname' maxlength='60' autocomplete='off' value='<?php echo $row['BName'];?>'
        required><br>
        <label>Building Number</label> <label style='padding-left:35px;'>Street</label><br>
        <input type='number' name = 'bNo' id='bNo' maxlength='5' autocomplete='off' value='<?php echo $row['BNo'];?>'required>
        <input type='text' name = 'stName' id='stName' maxlength='100' autocomplete='off' value='<?php echo $row['StName'];?>'required><br>
        <label>City</label>
        <label style='padding-left:115px'>Province/State/Territory</label><br>
        <input type='text' name = 'city' id='city' maxlength='30' autocomplete='off' value='<?php echo $row['City'];?>'>
        <input type='text' name = 'provstt' id='provstt' maxlength='30' autocomplete='off' value='<?php echo $row['ProvStTr'];?>'><br>
        <label>Country</label><br>
        <input type='text' name = 'country' id='country' maxlength='30' autocomplete='off' value='<?php echo $row['Country'];?>'><br>
        <div class='subcontainer'>
            <div class='start_block'>
                <label style='font-size:16pt'><b>Event Start:</b></label>
                <!-- this might cause issues -->
                <input required style="font-color:black"type='datetime-local' name='start' id = 'start' value='<?php echo $row['StartDateTime'];?>'autocomplete='off'>
            </div>
            <div class='end_block'>
                <label style='font-size:16pt'><b>Event End:</b></label>
                <!-- this might cause issues -->
                <input required style="font-color:black"type='datetime-local' name='end' id = 'end' value='<?php echo $row['EndDateTime'];?>'autocomplete='off'>
            </div>
        </div>
    </div>
    <input type='hidden' name='EventID' id='details' value='<?php echo $_POST['EventID']?>'>
    <input type='hidden' name='Altered' id='Altered' value='<?php echo true ?>'>
    <input type='hidden' name='BuildID' id='bid' value='<?php echo $row['BuildID'];?>'>
    <div class='logistics'>
        <h2 style='text-align:center'>Logistical Details</h2>
        <label for='ename'><b>Event Name</b></label><br>
        <input required type = 'text' autocomplete='off' name='ename' id='ename' value=<?php echo $row['EventName'];?>><br>
        <label for='attendees'><b>Number of Attendees:</b>
        <input required type = 'number' autocomplete='off' name='attendees' min='1' max='999' id='attendees' value=<?php echo $row['No_Attendees'];?>><br>
        <h3>Description:</h3>
            <textarea name='desc' id='desc' style='margin-right:200px' rows='4' min='1' max='500'cols='50'><?php echo $row['Description'];?></textarea>
    </div>
     <div class = 'block'>
        <h3> Invite Someone </h3>
        <form action='./send_invite.php' method='post'>
        <select id='emailselect' name='MemEmail' onfocus='this.size=5'>
        <?php
        while($rowset=mysqli_fetch_assoc($result4)){?>
        
            <option value='<?php echo $rowset['Email']?>'><?php echo $rowset['Fname']?> <?php echo $rowset['Lname']?></option><?php
        }
        ?>
        </select><button style='border-raidus:5px;border:1px solid black' class='invite-button' type='submit' name='invite' id='invite'>Send invite</button>
        <input type = 'hidden' name='EventID' id='remove' value='<?php echo $_POST['EventID']?>'>
        </form>
    </div>
    </div>
    <table class='middle'>
        <tr>
            <td>
        <button class='save'type='submit' name='Submit' id='Submit'><b>Save all changes<b></button>
        </form>
        </td>
        <td>
    <form action='./delete_event.php' method='post'>
        <input type = 'hidden' name='EventID' id='remove' value='<?php echo $_POST['EventID']?>'>
        <button class='deleter'type = 'submit' name='Delete' id='deleter'><b style='background-color:tomato;border-radius:30px;color:white'>Delete this event</b></button>
    </form>
    </td>
    </tr>
    </table>
      </body><?php
}
else{
    session_unset();
    header('Location: ./index.php');
    exit();
}
?>
