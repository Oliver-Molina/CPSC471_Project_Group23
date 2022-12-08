<?php 
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);
if(isset($_SESSION['Email'])){
    if(isset($_SESSION['Admin']) == false){
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
        table.buttons{
            margin-left:auto;
            margin-right:auto;
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
            background-color:orange;
            font-size:16pt;
            border:outset black 2px;
            border-radius:30px;
        }
        .discard_button{
            color:white;
            font-family:helvetica;
            background-color:maroon;
            margin-left:175px;
        }
        .submit_button{
            color:black;
            font-family:helvetica;
            margin-right:175px
        }
        .container{
            height:500px;
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
            border-bottom:1px solid;
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
        select{
            border:2px solid black;
            background-color:white;
            font-size:16pt;
            width:250px;
            font-family:helvetica;
        }
    </style>                 
    <html>
    <head>
    <title>Create Event</title>
    </head>
    <body>
        <h1>New Event</h1>
        <a style='font-family:helvetica' href= './events.php'>Back to Events</a><br>
        <a style='font-family:helvetica' href="./homepage.php">Homepage</a><br>
    </body>
    </html>
<?php
    $teams = 'SELECT ID, TName FROM TEAM WHERE TEAM.OrgID = ?';
    $stmt = $conn->prepare($teams);
    $stmt->bind_param('s',$_SESSION['OrgID']);
    $stmt->execute();
    $result1 = $stmt->get_result();
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
    ?>
    <form action='./eventcreator.php' method='post'>
    <div class='container'>
    <div class='address_block' id='a'>
        <h2 style='text-align:center'>Location Information</h2>
        <h3>Address:</h3>
        <label>Building Name</label>
        <input type='text' name = 'bname' id='bname' maxlength='60' autocomplete='off'required><br>
        <label>Building Number</label> <label style='padding-left:35px;'>Street</label><br>
        <input type='number' name = 'bNo' id='bNo' maxlength='5' autocomplete='off'required>
        <input type='text' name = 'stName' id='stName' maxlength='100' autocomplete='off'required><br>
        <label>City</label>
        <label style='padding-left:126px'>Province/State/Territory</label><br>
        <input type='text' name = 'city' id='city' maxlength='30' autocomplete='off'>
        <input type='text' name = 'provstt' id='provstt' maxlength='30' autocomplete='off'><br>
        <label>Country</label><br>
        <input type='text' name = 'country' id='country' maxlength='30' autocomplete='off'><br>
        <div class='subcontainer'>
            <div class='start_block'>
                <label style='font-size:16pt'><b>Event Start:</b></label>
                <!-- this might cause issues -->
                <input required style="font-color:black"type='datetime-local' name='start' id = 'start' autocomplete='off'>
            </div>
            <div class='end_block'>
                <label style='font-size:16pt'><b>Event End:</b></label>
                <!-- this might cause issues -->
                <input required style="font-color:black"type='datetime-local' name='end' id = 'end' autocomplete='off'>
            </div>
        </div>
    </div>
    <div class='logistics'>
        <h2 style='text-align:center'>Logistical Details</h2>
        <h3>Event Name:</h3>
        <input required type = 'text' autocomplete='off' name='ename' id='ename'><br>
        <h3>Number of Attendees:</h3>
        <input required type = 'number' autocomplete='off' name='attendees' min='1' max='999' id='ename'><br>
        <h3>Description:</h3>
            <textarea name='desc' id='desc' style='margin-right:200px' rows='4' min='1' max='500'cols='50'></textarea>
       
    </div>
    </div>
    <table class='buttons' style='margin-top:15px'>
        <tr>
            <th></th>
            <th style='font-family:helvetica;font-size:16pt'>Assigned Team</th>
            <th></th>
        </tr>
        <tr>
            <td><button class='submit_button' type='submit' name='Submit' id='Submit'><b>Save all changes<b></button></td>
       
        <td>
        <select id='team' name='TeamID' required>
            <?php while($row=mysqli_fetch_assoc($result1)){?>
            <option value='<?php echo $row['ID']?>'><?php echo $row['TName']?></option>
            <?php } ?>
        </select>
        </td>
    </form>
    <form action='./create_event.php'>
        <td><button class='discard_button' type='submit' name='Submit' id='discard'><b>Discard all changes</b></button></td>
    </form>
    </tr>
    </table>

<?php
}
else{
    session_unset();
    header('Location: ./index.php');
    exit();
}
?>
