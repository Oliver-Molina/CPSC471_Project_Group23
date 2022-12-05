<?php 
session_start();
if(isset($_SESSION['Email'])){
?>
    <!DOCTYPE html>
    <html>
	<style>
		.title_block{
			font-family: helvetica;
			text-align: center;

		}
		title,head{
			font-family: helvetica;
		}
	</style>
    <head>
    <title>Inventory</title>
    </head>
	<div class ='title_block'>
    <body>
        <h1>This is the Inventory Page</h1>
        <p>Here you will access your Inventory</p>
    </body>
	</div>
    </html>
	<!-- from https://www.viralpatel.net/dynamically-add-remove-rows-in-html-table-using-javascript/ -->
<html>
<head>
	<style>
		.tbheader{
			font-family: helvetica;
			text-align:center;
			
		}
		table.center{
			margin-left:auto;
			margin-right:auto;
		}
		table, th, td {
		border: 2px solid black;
		border-collapse: collapse;
		}
		th, td {
			background-color: #A3EAD9;
			font-family: helvetica;
			padding-left:30px;
			padding-right:30px;
			padding-top:10px;
			padding-bottom:10px;
			text-align:center;
		}
		.links{
			padding-top:20px;
			font-family: helvetica;
			text-align: center;
		}
	</style>
</head>
<!-- need to figure out how to insert things into the inventory-->
	</html>
<?php
	include 'db_connection.php';
	$query = 'SELECT CName, CType, Qty FROM Component WHERE Component.OrgID = ?';
	$user_query = $conn -> prepare($query);
	$user_query -> bind_param('s',$_SESSION['OrgID']);
	$user_query->execute();
	$results = $user_query->get_result();
?>
<html>
	<div class='tbheader'>
		<h3><u>Your Inventory</u></h3>
	</div>
	<table class='center'> 
		<tr> 
			<th>Item Name</th>
			<th>Type</th>
			<th>Quantity</th>
		</tr>
	</html>
	<?php
while($row = mysqli_fetch_assoc($results)){
	?>
	<html>
	<tr>
		<td><?php echo $row['CName']?>
		<td><?php echo $row['CType']?>
		<td><?php echo $row['Qty']?>
	</tr>
<?php }?>
<html>
</table>
<div class ='links'>
<a href="./homepage.php">Back to hompage</a><br>
</div>
</html>
<?php
}else{
    header('Location: ./index.php');
    exit();
}
?>