<?php 
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);
if(isset($_SESSION['Email'])){
    if(isset($_POST['EventID']) == false){
        header('Location: ./index.php?Invalid Event');
        exit();
    }
    include 'db_connection.php';  
    ?>
    <!DOCTYPE html>
    <style>
        h1{
            font-family:helvetica;
            text-align:center;
        }
        .container{
            overflow:scroll;
            font-family:helvetica;
            position:absolute;
            left:10%;
            right:10%;
            border:3px solid black;
            border-radius:30px;
            background: azure;
        }
        .address_block{
            padding-left:30px;
            width:40%;
            float:left;
            font-family:helvetica;
        }
        .subcontainer{
            border-top:1px solid black;
            border-bottom:1px solid black;
        }
        .logistics{
            width:50%;
            float:right;
            font-family:helvetica;
            border-left:1px solid black;
            padding-left:30px;
        }
        .start_block{
            width:48%;
            float:left;
            border-right:1px solid black;
            font-family:helvetica;
            font-size:12pt;
        }
        .end_block{
            width:40%;
            float:right;
            font-family:helvetica;

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
    $sql = 'SELECT EventName, No_Attendees, Description, StartDateTime, EndDateTime, EVENT_USES.BuildingID,
    BName, BNo, StName, City, ProvStTr, Country FROM EVENT_ JOIN EVENT_USES 
    ON EVENT_.EventID = EVENT_USES.EventID
    JOIN BUILDING ON BUILDING.ID = EVENT_USES.BuildingID
    WHERE EVENT_.EventID = ?';
    $query = $conn -> prepare($sql);
    $query->bind_param('i',$_POST['EventID']);
    $query->execute();
    $result=$query->get_result();
    $row=mysqli_fetch_assoc($result);
    ?>
    <div class='container'>
    <div class='address_block' id='a'>
        <h2 style='text-align:center'>Location Information</h2>
        <h3>Address:</h3>
        <p><?php echo $row['BName'];?>
        #<?php echo $row['BNo'];?> <?php echo $row['StName'];?>,
        <?php echo $row['City'];?>,
        <?php echo $row['ProvStTr'];?>,
        <?php echo $row['Country'];?>
        <div class='subcontainer'>
        <div class='start_block'>
            <h3>Event Start:</h3>
            <p><?php echo $row['StartDateTime']?></p>
        </div>
        <div class='end_block'>
            <h3>Event End:</h3>
            <p><?php echo $row['EndDateTime']?></p>
        </div>
    </div>
    </div>
    
    <div class='logistics'>
        <h2 style='text-align:center'>Logistical Details</h2>
        <h3>Event Name:</h3>
           <?php echo $row['EventName'];?></p>
        <h3>Number of Attendees:</h3>
            <p><?php echo $row['No_Attendees'];?></p>
        <h3>Description:</h3>
            <p style='margin-right:200px'><?php echo $row['Description'];?></p>
    </div>
    </div>

<?php
}
else{
    session_unset();
    header('Location: ./index.php');
    exit();
}
?>
