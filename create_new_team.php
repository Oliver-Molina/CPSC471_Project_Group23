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
            <h1>Create a new Team</h1>
			
            <form action = './create_new_team.php' method='post'>
			
                <label for="TName">Enter Team Name:</label><br>
                <input type='text' id='TName' name='TName_User' placeholder="Team Name" autocomplete="off"><br>
			
                <label for="Specialization">Enter Team Specialization:</label><br>
                <input type="text" id='Specialization' name="Specialization_User" placeholder="Specialization" autocomplete="off"><br>
			
                <button type='submit' value='Submit' name="Submit">Submit</button><br>
				
            </form>
			<?php
		
if(isset($_POST['Submit'])){
	if(!empty($_POST['TName_User']) && !empty($_POST['Specialization_User'])){
		
		$sql = 'INSERT INTO TEAM (ID, TName, Specialization, LeadEmail, OrgID) VALUES (?,?,?,?,?)';
		
		$teamName = $_POST['TName_User'];
		$specialization = $_POST['Specialization_User'];
		$email = $_SESSION['Email'];
		$orgID = $_SESSION['OrgID'];
		$id = '0';
		
		$query = $conn->prepare($sql);
        $query->bind_param('issss', $id, $teamName, $specialization, $email, $orgID);
        $query->execute();
		$result = $query->get_result();
    
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