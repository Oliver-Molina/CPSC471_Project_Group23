<?php 
session_start();
if (isset($_SESSION['Email'])) {
    include 'db_connection.php';
    $CName = $_POST['CName'];
    $CType = $_POST['CType'];
    $Qty = $_POST['Qty'];
    if (empty($CName) || empty($CType) || empty($Qty)) {
        header("Location: ./projects.php?error=Yikes");
    }


    $select = 'SELECT * FROM COMPONENT AS C WHERE CName = ? AND CType = ? AND OrgID = ?';
    $select_query = $conn->prepare($select);
    $select_query->bind_param("sss", $CName, $CType, $_SESSION["OrgID"]);
    $select_query->execute();
    $current_components = mysqli_fetch_assoc($select_query->get_result());
    if(!empty($current_components)){
        echo "here";
        echo $current_components['Qty'];

        $currentQty = $current_components['Qty'] + $Qty;

        echo $Qty;
        echo $currentQty;

        $update = 'UPDATE COMPONENT AS C SET Qty = ? WHERE CName = ? AND CType = ?';
        $update_query = $conn->prepare($update);
        $update_query->bind_param("iss", $currentQty, $CName, $CType);
        $update_query->execute();
    } 
    else{
        echo "actually here";
        $insertion = 'INSERT INTO COMPONENT(CName, Qty, CType, OrgID) VALUES(?,?,?,?)';
        $insert_query = $conn->prepare($insertion);
        $insert_query->bind_param("siss", $CName, $Qty, $CType, $_SESSION['OrgID']);
        $insert_query->execute();
    }
    
    header('Location: ./inventory.php');
    exit();
}
else{
    session_unset();
    header('Location: ./index.php');
    exit();
}
?>
