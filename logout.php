<?php
session_start();
session_unset();
include 'db_connection.php';
mysqli_close($conn);
session_destroy();
header("Location: ./index.php");
exit();
?>