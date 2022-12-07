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
        <title>New Project</title>
        </head>
        <style>
            .button{
                width:30px;
            }
        </style>
        <body>
            <h1>Create a new Project</h1>
            <form action = './create_new_project.php' method='post'>
                <label for="PName">Enter Project Name:</label><br>
                <input required type='text' id='PName' name='PName' placeholder="Project Name" autocomplete="off"><br>
                <label for="StartDate">Enter Project Start Date:</label><br>
                <input required type="date" id='StartDate' name="StartDate" placeholder=<?php echo date('Y/m/d')?> autocomplete="off"><br>
                <label for="EndDate">Enter Project End Date:</label><br>
                <input required type="date" id='EndDate' name="EndDate" placeholder=<?php echo date('Y/m/d')?> autocomplete="off"><br>
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
