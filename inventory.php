<?php 
session_start();
if(isset($_SESSION['Email'])){
?>
    <!DOCTYPE html>
    <html>
	<style>
		title,head{
			font-family: helvetica;
		}
	</style>
    <head>
		
    <title>Inventory</title>
    </head>

    <body>
        <h1>This is the Inventory Page</h1>
        <p>Here you will access your Inventory</p>
        <a href="./homepage.php">homepage</a><br>
    </body>
    </html>

	<!-- from https://www.viralpatel.net/dynamically-add-remove-rows-in-html-table-using-javascript/ -->
<html>
<head>
	<style>
		table, th, td {
		border: 2px solid black;
		border-collapse: collapse;
		}
		th, td {
		background-color: #A3EAD9;
		font-family: helvetica;
		}
	</style>
</head>
	</html>
<?php
include 'db_connection.php';
$query = 'SELECT CName, CType, Qty FROM Component WHERE Component.OrgID = ?';
$user_query = $conn -> prepare($query);
$user_query -> bind_param('s',$_SESSION['OrgID']);
$user_query->execute();
$results = $user_query->get_result();
echo 
	"<table style.border='1'> 
	<tr> 
	<th>Name</th>
	<th>Type</th>
	<th>Quantity</th>
	</tr>";
while($row = mysqli_fetch_assoc($results)){
	echo '<tr>';
	echo '<td>'.$row['CName'];
	echo '<td>'.$row['CType'];
	echo '<td>'.$row['Qty'];
	echo '</tr>';
}
echo'</table>';}
else{
    header('Location: ./index.php');
    exit();
}
?>

