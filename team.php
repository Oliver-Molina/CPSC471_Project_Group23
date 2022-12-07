<?php 
session_start();
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
            background:floralwhite;
            padding-top:75px;
            padding-bottom:200px;
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
            margin-bottom:20px;
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
            display:block;
            text-align:center;
            padding-top:5px;
            padding-bottom:30px;
            font-family:helvetica;
		    border-collapse: collapse;
        }

    </style>
    <!DOCTYPE html>
    <html>
    <head>
        <title>Team</title>
    </head>
    <div class ="container">
        <div class="title_block">
            <body>
                <h1>This is the Team Page</h1>
                <p>Here you will access info on a specific team</p>
            </body>
    </html>
    <div class="myTable">
        <?php
        include 'db_connection.php';
        $query = 'SELECT TName, Specialization, LeadEmail FROM TEAM WHERE ID = ?';
        $user_query = $conn->prepare($query);
        $user_query->bind_param('s',$_POST['teamID']);
        $user_query->execute();
        $results = $user_query->get_result();
        ?>
    <html>
        <table class='center'> 
            <tr> 
                <th>Team Name</th>
                <th>Team Specialization</th>
                <th>Team Lead</th>
            </tr>
    </html>
    <?php
    while($row = mysqli_fetch_assoc($results)){?>
        <html>
            <div class='trow'>
                <tr>
                    <td><?php echo $row['TName'];?>
                    <td><?php echo $row['Specialization'];?>
                    <td><?php echo $row['LeadEmail'];?>
                </tr>
            </div>
        </html>
        <?php
    }?>
    <html>
</table>
    <div class="back_links">
        <a href= './teams.php'>Back to Teams</a><br>
        <a href="./homepage.php">Homepage</a>
    </div>
</div>
<html>
<?php
    $isAdmin_Query->execute();
    if ($row = mysqli_fetch_assoc($isAdmin_Query->get_result())) {
        ?>
        
			
        <form action="./add_member.php" id='add_member' method='post'>
            <button type="submit" name="Submit" value='Submit'>Add member</button>
        </form>
		
		<form action="./remove_member.php" id='remove_member' method='post'>
            <button type="submit" name="Submit" value='Submit'>Remove member</button>
        </form>
		
			
        <?php
    }


}else{
    session_unset();
    header('Location: ./index.php');
    exit();
}
?>