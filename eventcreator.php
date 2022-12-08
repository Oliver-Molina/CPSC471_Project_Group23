<?php 
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);
if(isset($_SESSION['Email'])){
   if(isset($_SESSION['Admin']) == false){
        header('Location ./index.php?unauthorized');
        exit();
    }
    include 'db_connection.php';

    $sql = 'SELECT ID FROM BUILDING WHERE BName = ? AND BNo = ? AND StName = ? 
    AND City = ? AND ProvStTr = ? AND Country = ?';
    $bName = $_POST['bname'];
    $stName = $_POST['stName'];
    $bNo = $_POST['bNo'];
    $city = $_POST['city'];
    $provsttr = $_POST['provstt'];
    $country = $_POST['country'];
    $query = $conn->prepare($sql);
    $query->bind_param('sissss', $bName, $bNo, $stName, $city, $provsttr, $country);
    $query->execute();
    $result = $query->get_result();
    $new_building = false;
    if(mysqli_num_rows($result)==0){
        $sqlB = 'INSERT INTO BUILDING(BName, BNo, StName, City, ProvStTr, Country) VALUES (?,?,?,?,?,?)';
        $query2 = $conn->prepare($sqlB);
        $query2->bind_param('sissss', $bName, $bNo, $stName, $city, $provsttr, $country);
        $query2->execute();
        $query3= $conn->prepare('SELECT LAST_INSERT_ID()');
        $query3->execute();
        $result3 = $query3->get_result();
        if(empty($result3)==false){
            $buildingID = mysqli_fetch_assoc($result3);
        }
        else{
            header('Location ./index.php?why are you like this');
            exit();
        }
    }
    else{
        $rowM = mysqli_fetch_assoc($result);
        $buildingID = $rowM['ID'];
    }
    $teamID = $_POST['TeamID'];
    $start= $_POST['start'];             
    $end = $_POST['end'];
    $name = $_POST['ename'];
    $attendees = $_POST['attendees'];
    $dsc = $_POST['desc'];
    $update_query = 'INSERT INTO EVENT_(EventName, No_Attendees, Description, StartDateTime, EndDateTime, HostID, PlannerID) VALUES (?,?,?,?,?,?,?)';
    $final_statement = $conn->prepare($update_query);
    $final_statement->bind_param('sissssi',$name,$attendees,$dsc,$start,$end,$_SESSION['OrgID'],$teamID);
    $final_statement->execute();
    $getLastID = 'SELECT LAST_INSERT_ID() AS I';
    $query4=$conn->prepare($getLastID);
    $query4->execute();
    $result4=$query4->get_result();
    $lastInsert = mysqli_fetch_assoc($result4);
    $lastInsertID = $lastInsert['I'];
    $insert_not_exists = $conn->prepare('INSERT INTO EVENT_USES(BuildingID, EventID) VALUES(?,?)');
    $insert_not_exists->bind_param('ii',$buildingID,$lastInsertID);
    $insert_not_exists->execute();
    header('Location:./events.php');
    exit();
    #this is what handles deleting events
}
else{
    session_unset();
    header('Location: ./index.php');
    exit();
}
?>
