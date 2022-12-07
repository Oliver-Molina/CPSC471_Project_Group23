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
        <title>Add New Item</title>
        </head>
        <style>
            .button{
                width:30px;
            }
        </style>
        <body>
            <h1>Add New Item</h1>
            <form action = './add_item.php' method='post'>
                <label for="CName">Enter Component Name:</label><br>
                <input required type='text' id='CName' name='CName' autocomplete="off"><br>
                <label for="CType">Enter Component Type:</label><br>
                <input required type="text" id='CType' name="CType" autocomplete="off"><br>
                <label for="Qty">Enter Quantity of Component Added:</label><br>
                <input required type="number" id='Qty' name="Qty" autocomplete="off"><br>
                <button type='submit' value='Submit' name="Submit">Submit</button><br>
            </form>
            <a href="./homepage.php">homepage</a><br>
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
