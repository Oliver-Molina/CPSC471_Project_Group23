<?php 
session_start();
if(isset($_SESSION['Email'])){
    if(isset($_POST['projectID'])){
        $_SESSION['projectID'] = $_POST['projectID'];
    }
    else{
        header('Location: ./index.php?error=Invalid Project');
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
        <title>Project</title>
    </head>
    <div class ="container">
        <div class="title_block">
            <body>
                <h1>This is the Project Page</h1>
                <p>Here you will access info on a specific project</p>
            </body>
    </html>
    <div class="myTable">
        <?php
        include 'db_connection.php';
        $query = 'SELECT DName, StartDate, EndDate FROM DELIVERABLE WHERE ProjectID = ?';
        $user_query = $conn->prepare($query);
        $user_query->bind_param('s',$_POST['projectID']);
        $user_query->execute();
        $results = $user_query->get_result();
        ?>
    <html>
        <table class='center'> 
            <tr> 
                <th>Deliverable</th>
                <th>Start Date</th>
                <th>Deadline</th>
            </tr>
    </html>
    <?php
    while($row = mysqli_fetch_assoc($results)){?>
        <html>
            <div class='trow'>
                <tr>
                    <td><?php echo $row['DName'];?>
                    <td><?php echo $row['StartDate'];?>
                    <td><?php echo $row['EndDate'];?>
                </tr>
            </div>
        </html>
        <?php
    }?>
    <html>
</table>
    <div class="back_links">
        <a href= './projects.php'>Back to Projects</a><br>
        <a href="./homepage.php">Homepage</a>
    </div>
</div>
<html>
<?php
    $isAdmin_Query->execute();
    if ($row = mysqli_fetch_assoc($isAdmin_Query->get_result())) {
        ?>
        <form action="./edit_project.php" id='edit_project' method='post'>
            <button type="submit" name="Submit" value='Submit'>Edit this project</button>
        </form>
        <?php
    }


}else{
    header('Location: ./index.php');
    exit();
}
?>
