<?php 
session_start();
if(isset($_SESSION['Email'])){
    if(!isset($_SESSION['projectID'])){
        header("Location: ./project.php?error=Something Went Wrong");
        exit();
    }
    $projectID = $_SESSION['projectID'];
    include 'db_connection.php';  
    ?>
    <!DOCTYPE html>               
    <html>
    <head>
    <title>Edit Event</title>
    </head>
    <body>


        <?php
            $project = "SELECT * FROM PROJECT WHERE PROJECT.ID = ?";
            $project_query = $conn->prepare($project);
            $project_query->bind_param("i", $projectID);
            $project_query->execute();
            $result = mysqli_fetch_assoc($project_query->get_result());
        ?>
        <h1>Edit <?php  echo $result['PName'];?></h3>

        <form action = './edit_project.php' method='post'>
                <label for="PName">Enter Project Name:</label><br>
                <input required type='text' id='PName' name='PName' value='<?php echo $result['PName'];?>' autocomplete="off"><br>
                <label for="EndDate">Enter Project End Date:</label><br>
                <input required type="date" id='EndDate' name="EndDate" value='<?php echo $result['EndDate'];?>' autocomplete="off"><br>
                <button type='submit' value='Submit' name="Submit">Submit</button><br>
            </form>
            <a href="./homepage.php">homepage</a><br>
    </body>
    </html>
<?php

}
else{
    session_unset();
    header('Location: ./index.php');
    exit();
}
?>
