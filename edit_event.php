<?php 
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);
if(isset($_SESSION['Email'])){
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
        button{
            padding:16px;
            color:white;
            background-color:green;
            font-size:16pt;
            border:outset black 2px;
            border-radius:5px;
    
        }
        .container{
            height:450px;
            margin-top:10px;
            margin-left:10px;
            margin-right:10px;
            background-color:white;
            font-family:helvetica;
            margin-left:auto;
            margin-right:auto;
            left:5%;
            right:5%;
            border:3px solid black;
            border-radius:30px;
        }
        .address_block{
            padding-left:30px;
            width:45%;
            float:left;
            font-family:helvetica;
        }
        .subcontainer{
            float: left;
            border-top:1px solid black;
            border-bottom:1px solid black;
        }
        .logistics{
            width:48%;
            float:right;
            font-family:helvetica;
            border-left:1px solid black;
            padding-left:30px;
        }
        .start_block{
            padding-top:15px;
            width:49%;
            float:left;
            text-align:center;
            border-right:1px solid black;
            border-left:1px solid black;
            border-bottom:1px solid
            font-family:helvetica;
            font-size:12pt;
        }
        .end_block{
            padding-top:15px;
            width:49%;
            float:right;
            text-align:center;
            border-right:1px solid black;
            font-family:helvetica;
            font-size:12pt;

        }
    </style>                 
    <html>
    <head>
    <title>Event</title>
    </head>
    <body>
        <h1>Event <?php  echo $_POST['EventID'];?></h3>
        <p>Here you will access info on a specific event</p>
        <a href= './events.php'>Back to Events</a><br>
        <a href="./homepage.php">Homepage</a><br>
    </body>
    </html>
<?php
    $sql = 'SELECT EventName, No_Attendees, Description, StartDateTime, EndDateTime, EVENT_USES.RoomNo AS EuRN,
    BName, BNo, StName, City, ProvStTr, Country, EVENT_USES.BuildingID AS BuildID FROM EVENT_ JOIN EVENT_USES 
    ON EVENT_.EventID = EVENT_USES.EventID
    JOIN ROOM ON EVENT_USES.RoomNo = ROOM.RoomNo
    JOIN BUILDING ON ROOM.BuildingID = BUILDING.ID
    WHERE EVENT_.EventID = ?';
    $query = $conn -> prepare($sql);
    $query->bind_param('i',$_POST['EventID']);
    $query->execute();
    $result=$query->get_result();
    $row=mysqli_fetch_assoc($result);
    ?>
    <div class='container'>
    <div class='address_block' id='a'>
        <form name='details' action='./eventmanager.php' method='post'>
        <h2 style='text-align:center'>Location Information</h2>
        <h3>Address:</h3>
        <label>Building Name</label>
        <label style='padding-left:50px'>Room Number</label><br>
        <input type='text' name = 'bname' id='bname' maxlength='60' autocomplete='off' value='<?php echo $row['BName'];?>'
        required>
        <input type='text' name = 'roomNo' id='roomNo' maxlength='8' autocomplete='off' value='<?php echo $row['EuRN'];?>'
        required><br>
        <label>Building Number</label> <label style='padding-left:35px;'>Street</label><br>
        <input type='number' name = 'bNo' id='bNo' maxlength='5' autocomplete='off' value='<?php echo $row['BNo'];?>'
        required>
        <input type='text' name = 'stName' id='stName' maxlength='100' autocomplete='off' value='<?php echo $row['StName'];?>' 
        required><br>
        <label>City</label>
        <label style='padding-left:126px'>Province/State/Territory</label><br>
        <input type='text' name = 'city' id='city' maxlength='30' autocomplete='off' value='<?php echo $row['City'];?>'>
        <input type='text' name = 'provstt' id='provstt' maxlength='30' autocomplete='off' value='<?php echo $row['ProvStTr'];?>'><br>
        <label>Country</label><br>
        <input type='text' name = 'country' id='country' maxlength='30' autocomplete='off' value='<?php echo $row['Country'];?>'><br>
        <div class='subcontainer'>
            <div class='start_block'>
                <label style='font-size:16pt'><b>Event Start:</b></label>
                <!-- this might cause issues -->
                <input style="font-color:black"type='datetime-local' name='start' id = 'start' value='<?php echo date('c',strtotime($row['StartDateTime']));?>'
                autocomplete='off'>
            </div>
            <div class='end_block'>
                <label style='font-size:16pt'><b>Event End:</b></label>
                <!-- this might cause issues -->
                <input style="font-color:black"type='datetime-local' name='end' id = 'end' value='<?php echo date('c',strtotime($row['EndDateTime']));?>'
                autocomplete='off'>
            </div>
        </div>
    </div>
    <div class='logistics'>
        <h2 style='text-align:center'>Logistical Details</h2>
        <h3>Event Name:</h3>
        <input required type = 'text' autocomplete='off' name='ename' id='ename' value=<?php echo $row['EventName'];?>><br>
        <h3>Number of Attendees:</h3>
        <input required type = 'number' autocomplete='off' name='attendees' min='1' max='999' id='ename' value=<?php echo $row['No_Attendees'];?>><br>
        <h3>Description:</h3>
            <textarea name='desc' id='desc' style='margin-right:200px' rows='4' min='1' max='500'cols='50'><?php echo $row['Description'];?></textarea>
    </div>
    </div>
    <input type='hidden' name='EventID' id='details' value='<?php echo $_POST['EventID']?>'>
    <input type='hidden' name='Altered' id='Altered' value='<?php echo true ?>'>
    <input type='hidden' name='BuildID' id='bid' value='<?php echo $row['BuildID'];?>'>
    <button class='b1' id='buttonA' type='submit' name='Submit' id='Submit'><b>Save all changes<b></button>
    </form>

<?php
}
else{
    session_unset();
    header('Location: ./index.php');
    exit();
}
?>
