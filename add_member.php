<?php 
session_start();
if(isset($_SESSION['Email'])){
    include 'db_connection.php';
    $isAdmin_Query->execute();
    if ($row = mysqli_fetch_assoc($isAdmin_Query->get_result())) {
        ?>
        <!DOCTYPE html>
        <html>
        <head>
        <title>New Team</title>
        </head>
        <style>
            .button{
                width:30px;
            }
        </style>
        <body>
            <h1>Add member to team</h1>
			
            <form action = './add_member.php' method='post'>
			
                <label for="FName">Enter Member First Name:</label><br>
                <input type='text' id='FName' name='FName_Mem' placeholder="First Name" autocomplete="off"><br>
			
                <label for="Specialization">Enter Member Last Name:</label><br>
                <input type="text" id='LName' name="LName_Mem" placeholder="Last Name" autocomplete="off"><br>
			
                <button type='submit' value='Submit' name="Submit">Submit</button><br>
				
            </form>
			<?php
if(isset($_POST['Submit'])){
	if(!empty($_POST['FName_Mem']) && !empty($_POST['LName_Mem'])){
		
		$firstN = $_POST['FName_Mem'];
		$lastN = $_POST['LName_Mem'];
		
		$query1 = "SELECT Email FROM MEMBER WHERE Fname = ?, Lname = ?" ;
		$user_query1 = $conn->prepare($query1);
        $user_query1->bind_param('ss', $firstN, $lastN);
        $user_query1->execute();
        $results1 = $user_query1->get_result();
		
		$memEmail = $results1; 
		$teamID = $_POST['teamID'];
		$query2 = "INSERT INTO BELONGS((MEmail, Team_ID) values ('$memEmail', '$teamID'))";
		
		$run = mysqli_query($conn, $query) or die(mysqli_error());
		
	}
}			
			?>
			
            <a href="./homepage.php"> Homepage </a>
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