<!DOCTYPE html>
<style>
    html{
        background:#e1faf9;
    }
    table.center{
        background:white;
        border:solid black 2px;
        font-family:'helvetica neue';
        font-size:16pt;
        margin-left:auto;
        margin-right:auto;
        border-collapse:collapse;
    }
    .scrollblock{
        background:#e1faf9;
        border:solid black 2px;
        overflow-y:scroll;
        overflow-x:scroll;
        height:650px;
    }
    th,td{
        padding-top:10px;
        padding-bottom:10px;
        padding-left:20px;
        padding-right:20px;
        border:solid black 1px;
        border-collapse:collapse;
        text-align:center;
    }
    button{
        text-align:center;
        width:auto;
        height:auto;
        border:5px solid #0ad3ff;
        border-radius:1px;
        font-family:helvetica;
        font-size:14pt;
        background:#0ad3ff;
    }
</style>
<html>
<?php
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);
if(isset($_SESSION['Email'])==false){
    header('Location:./index.php');
    exit();
}
else{
    include 'db_connection.php';
    $email = $_SESSION['Email'];
    $orgID = $_SESSION['OrgID'];
    $query = 'SELECT Fname, Lname, Gender, MEMBER.Email AS MEmail, ADMIN.Email AS AEmail
     FROM (MEMBER LEFT JOIN ADMIN ON MEMBER.Email = ADMIN.Email) WHERE OrgID = ?';
    $user_query = $conn->prepare($query);
    $user_query->bind_param('s',$orgID);
    $user_query->execute();
    $result = $user_query->get_result();
    ?>
    <title>Directory</title>
    <h1 style="font-family:helvetica;text-align:center;padding-bottom:10px;">Organization Directory</h1>
    <div class='scrollblock'>
    <table class = 'center'>
        <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Gender</th>
            <th>Email Address</th>
            <th>User type</th>
            <?php
            if(isset($_SESSION['Admin'])){
                ?>
            <th>Promote to Admin</th>
            <th>Kick</th>
            <?php
            }?>
        </tr>
    <?php
    while($row = mysqli_fetch_assoc($result)){
        ?>
        <tr>
            <td><?php echo $row['Fname'];?></td>
            <td><?php echo $row['Lname'];?></td>
            <td><?php echo $row['Gender'];?></td>
            <td><?php echo $row['MEmail'];?></td>
            <?php
                if(empty($row['AEmail'])){
                    ?><td style="color:#1E90FF"><?php echo 'Member';?></td><?php
                }
                else{
                    ?><td style="color:tomato"><b><?php echo 'Admin';?></b></td><?php
                }
                if(isset($_SESSION['Admin']) && $row['MEmail']!=$_SESSION['Email']){
                    ?>
                <td>
                    <form action='./promote.php' method='post'>
                    <input type='hidden' name='MemEmail' value='<?php echo $row['MEmail']?>'>
                        <button type='Submit'name='sub'>Promote</button>
                    </form>
                </td>
                <td>
                    <form action='./kick.php' method='post'>
                    <input type='hidden' name='MemEmail' value='<?php echo $row['MEmail']?>'>
                    <button type='Submit'name='sub'>Kick</button>
                    </form>
                </td><?php
                    }
                else{
                    ?>
                    <td>Unavailable</td>
                    <td>Unavailable</td>
        
            </tr>
            <?php
            }
        }
    ?></table></div>
    <a style='font-family:helvetica;font-size:16pt' href='./homepage.php'>Homepage</a>
    <?php
}?>