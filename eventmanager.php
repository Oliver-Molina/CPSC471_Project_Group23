<?php 
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);
if(isset($_SESSION['Email'])){
    if(isset($_POST['EventID']) == false){
        header('Location: ./index.php?Invalid Event');
        exit();
    }
    else if(isset($_SESSION['Admin']) == false){
        header('Location ./index.php?unauthorized');
        exit();
    }
    include 'db_connection.php';
    
    $sql = 'SELECT * FROM BUILDING WHERE 
    ID = ? AND BName = ? AND BNo = ? AND StName = ? 
    AND City = ? AND ProvStTr = ? AND Country = ?';
    $event = $_POST['EventID'];
    $bName = $_POST['bname'];
    $stName = $_POST['stName'];
    $bNo = $_POST['bNo'];
    $city = $_POST['city'];
    $provsttr = $_POST['provstt'];
    $country = $_POST['country'];
    $bID = $_POST['BuildID'];
    $query = $conn->prepare($sql);
    $query->bind_param('isissss',$bID, $bName, $bNo, $stName, $city, $provsttr, $country);
    $query->execute();
    $result = $query->get_result();
    $new_building = false;
    if(mysqli_num_rows($result)==0){
        $sqlB = 'INSERT INTO BUILDING(BName, BNo, StName, City, ProvStTr, Country) VALUES
        (?,?,?,?,?,?)';
        $query2 = $conn->prepare($sqlB);
        $query2->bind_param('sissss', $bName, $bNo, $stName, $city, $provsttr, $country);
        $query2->execute();
        $query3= $conn->prepare('SELECT LAST_INSERT_ID()');
        $query3->execute();
        $result3 = $query3->get_result();
        if(empty($result3)==false){
            $_POST['BuildID']=mysqli_fetch_assoc($result3);
        }
        else{
            header('Location ./index.php?why are you like this');
            exit();
        }
    }
    $insert_not_exists = $conn->prepare('INSERT IGNORE INTO EVENT_USES(BuildingID, EventID) VALUES(?,?)');
    $insert_not_exists->bind_param('ii',$_POST['BuildID'],$_POST['EventID']);
    $insert_not_exists->execute();
    $start= $_POST['start'];                  
    $end = $_POST['end'];
    $name = $_POST['ename'];
    $attendees = $_POST['attendees'];
    $dsc = $_POST['desc'];
    $update_query = 
    'UPDATE EVENT_ SET EventName = ?, No_Attendees = ?, Description = ?, StartDateTime = ?, EndDateTime=?
    WHERE EventID = ?';
    $final_statement = $conn->prepare($update_query);
    $final_statement->bind_param('sisssi',$name, $attendees,$dsc,$start,$end,$event);
    $final_statement->execute();
    $_SESSION['EventID'] = $event;
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
