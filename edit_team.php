<?php 
session_start();
if(isset($_SESSION['Email'])){
    if(!isset($_SESSION['teamID'])){
        header("Location: ./team.php?error=Something Went Wrong");
        exit();
    }
	
	
    $teamID = $_SESSION['teamID'];
    include 'db_connection.php';  
 ?>
    <!DOCTYPE html>
    <html>
    <head>
        <title>Team</title>
    </head>
    <div class ="container">
        <div class="title_block">
            <body>
                <p>List of members in the team:</p>
				
            </body>
    </html>
    <div class="myTable">
        <?php
        include 'db_connection.php';
        $query = 'SELECT Member.Fname, Member.Lname, Member.Email FROM MEMBER JOIN BELONGS ON Member.Email = Belongs.MEmail WHERE Team_ID = ?';
        $user_query = $conn->prepare($query);
        $user_query->bind_param('s',$teamID);
        $user_query->execute();
        $results = $user_query->get_result();
        ?>
    <html>
        <table class='center'> 
            <tr> 
                <th>First Name</th>
                <th>Last Name</th>
                <th>Member Email</th>
            </tr>
    </html>
    <?php
    while($row = mysqli_fetch_assoc($results)){?>
        <html>
            <div class='trow'>
                <tr>
                    <td><?php echo $row['Fname'];?>
                    <td><?php echo $row['Lname'];?>
                    <td><?php echo $row['Email'];?>
                </tr>
            </div>
        </html>
        <?php
    }?>
    <html>
			</table>
			<form action="./add_member.php" id='add_member' method='post'>
                <button type="submit" name="Submit" value='Submit'>Add member</button>
            </form>
			
			<form action="./remove_member.php" id='remove_member' method='post'>
                <button type="submit" name="Submit" value='Submit'>Remove member</button>
            </form>
	
	<div class="back_links">
				<a href="./homepage.php">homepage</a><br>
				<a href="./teams.php">back to teams page</a><br>
				</div>
				
				</html>
<?php
}
else{
    header('Location: ./index.php');
    exit();
}
?>
