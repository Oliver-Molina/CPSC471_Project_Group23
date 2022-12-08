<?php 
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);
if(isset($_SESSION['Email'])){
    if(isset($_POST['teamID'])){
        $_SESSION['teamID'] = $_POST['teamID'];
    }
    else{
        header('Location: ./index.php?error=Invalid Team');
        exit();
    }
    ?>
    <style>
         .container{
            background:white;
            padding-top:10px;
            padding-bottom:10px;
        }
        .myTable{
            text-align:center;
        }
        title, head, body, .trow{
            font-family:helvetica;
            text-align:center;
        }
        table.center{
            background:white;
            border-collapse:collapse;
            margin-top:30px;
            margin-left:auto;
            margin-right:auto;
    
            padding-top: 50px;;
            padding-bottom:20px;
        }
        td, th, tr{
            text-align:center;
            font-family:helvetica;
            padding-left:10px;
            padding-right:10px;
            padding-top:10px;
            padding-bottom:10px;
            border-spacing:0;
            border:1px outset tomato;
            background-color:solid white;
            border-collapse:collapse;
        }
        .title_block{
            text-align:center;
            padding-top:5px;
            padding-bottom:5px;
            font-family:helvetica;
		    border-collapse: collapse;
        }
        .directory{
            font-size:16pt;
            font-family:helvetica;
            border:3px tomato;
        }
        table.dirtable{
            margin-left:auto;
            margin-right:auto;
            border-collapse:collapse;
            margin-top:50px;
            margin-bottom:50px
        }
        .back_links{
            margin-top:10px;
        }
    </style>
    <!DOCTYPE html>
    <html>
    <head>
        <title>Team</title>
    </head>
    
    <?php
    include 'db_connection.php';
    $query = 'SELECT Fname, Lname, Email FROM TEAM, MEMBER WHERE LeadEmail = Email AND TEAM.ID = ?';
    $user_query = $conn->prepare($query);
    $user_query->bind_param('s',$_POST['teamID']);
    $user_query->execute();
    $results = $user_query->get_result();
    $entry = mysqli_fetch_assoc($results);
    ?>
     <div class="title_block">
        <h1>This is the Team Page</h1>
        <p>Here you will access info on a specific team</p>
    </div>
<div class ="container">
    <div class='contact'>    
        <h2>Your Team Lead:</h2>
        <div class='NameField'>
            <?php echo $entry['Fname'];?><?php echo $entry['Lname'];?><br>
        </div>
        <div class=EmailField>
            <?php echo $entry['Email']?><br>
        </div>
    </div>
    <div class="back_links">
            <a href= './teams.php'>Back to Teams</a><br>
            <a href="./homepage.php">Homepage</a>
    </div>
    <?php
        $query = 'SELECT * FROM DELIVERABLE JOIN TEAM ON TeamID = ID WHERE TEAM.ID = ?';
        $user_query = $conn->prepare($query);
        $user_query->bind_param('i',$_POST['teamID']);
        $user_query->execute();
        $result = $user_query->get_result();
    ?>
    <div class='DelivInfo'>
        <h2>Deliverables</h2>
        <table class = center>
            <tr>
                <th>Deliverable Name</th>
                <th>Start Date</th>
                <th>Due Date</th>
            </tr>
        <?php
        while($row=mysqli_fetch_assoc($result)){
            ?>
            <tr>
                <td><?php echo $row['DName'];?></td>
                <td><?php echo $row['StartDate'];?></td>
                <td><?php echo $row['EndDate'];?></td>
            </tr>
            <?php
        }?>
        </table>
    </div>
    <?php
        unset($query);
        $query = 'SELECT Fname, Lname, Email FROM MEMBER AS M JOIN BELONGS AS B ON M.Email = B.MEmail WHERE B.Team_ID=?';
        $who_query = $conn->prepare($query);
        $who_query->bind_param('i',$_SESSION['teamID']);
        $who_query->execute();
        $resultset = $who_query->get_result();
    ?>
    <div class='directory'>
        <h2>Team Members</h2>
       <table class='dirtable'>
        
        <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Email</th>
        </tr>
    <?php 
        while($rowset=mysqli_fetch_assoc($resultset)){
            ?>
            <tr>
                <td><?php echo $rowset['Fname']?></td>
                <td><?php echo $rowset['Lname']?></td>
                <td><?php echo $rowset['Email']?></td>
            </tr><?php
        }?>
        </table>
    </div>
    

<?php
   $isAdmin_Query->execute();
   if($row = mysqli_fetch_assoc($isAdmin_Query->get_result())){
       ?>
        <div class='edit_button'>
            <form action="./edit_team.php" id='edit_team' method='post'>
                <button style='margin-top:10px' type="submit" name="Submit" value='Submit'>Edit this team</button>
            </form>
        </div>
    <?php
   }
}else{
    session_unset();
    header('Location: ./index.php');
    exit();
}
?>
</div>