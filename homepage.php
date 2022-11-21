<!DOCTYPE html>
<html>

<head>
    <title>Homepage</title>

</head>

<body>
    <h1>Welcome to your homepage</h1>
    <p>This page will display your options for accessing org website info.</p>
    <?php
    include 'db_connection.php';
    $conn = OpenCon();
    if(is_string($conn)){
        echo($conn);
    }
    else{
        echo "Connected Successfully<br>";
        if($client = $conn->query("SELECT * FROM food_inventory.daily_client_needs")){
            while($row = $client->fetch_assoc()){
                echo '<b>'.$row["ClientID"].'</b> ';
                echo '<b>'.$row["Client"].'</b> ';
                echo '<b>'.$row["WholeGrains"].'</b> ';
                echo '<b>'.$row["FruitVeggies"].'</b> ';
                echo '<b>'.$row["Protein"].'</b> ';
                echo '<b>'.$row["Other"].'</b> ';
                echo '<b>'.$row["Calories"].'</b> <br>';
                
            }
        }
        CloseCon($conn);
    }
    ?>
    <a href="./events.php">Events</a>
    <a href="./projects.php">Projects</a>
    <a href="./teams.php">Teams</a>
    <a href="./inventory.php">Inventory</a>
</body>
</html>