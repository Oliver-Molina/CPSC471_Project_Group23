<?php 
session_start();    
include 'db_connection.php';
if(isset($_SESSION['Email'])){

    $isAdmin_Query->execute();
    if ($row = mysqli_fetch_assoc($isAdmin_Query->get_result())) {
        ?>
        <!DOCTYPE html>
        <html>
        <head>
        <title>Delete member</title>
        </head>
        <style>
            .button{
                width:30px;
            }
        </style>
        <body>
            <h1>Remove member from team</h1>
			
            <form action = './remove_member.php' method='post'>
			
                <label for="Email">Enter Member Email:</label><br>
                <input type='text' id='Email' name='Mem_Email' autocomplete="off"><br>
			
                <button type='submit' value='Submit' name="Submit">Submit</button><br>
				
            </form>
			<?php
if(isset($_POST['Submit'])){
	if(!empty($_POST['Mem_Email'])){
		
		$query2 = "DELETE FROM BELONGS WHERE Belongs.MEmail = ? AND Belongs.Team_ID = ?";
		
		$memEmail = $_POST['Mem_Email']; 
		$teamID = $_SESSION['teamID'];
		
		$user_query2 = $conn->prepare($query2);
        $user_query2->bind_param('si', $memEmail, $teamID);
        $user_query2->execute();
		$results2 = $user_query2->get_result();
		
	}
}			
			?>
			<div class="back_links">
        <a href= './teams.php'>Back to Teams</a><br>
        <a href="./homepage.php">Homepage</a>
    </div>
        </body>
        </html>
        <?php
    }
    else{
        session_unset();
        header('Location: ./index.php?error=You are not supposed to be there');
    }
}
else{
    session_unset();
    header('Location: ./index.php?');
    exit();
}
?>