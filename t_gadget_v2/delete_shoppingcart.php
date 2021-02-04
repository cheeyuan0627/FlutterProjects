<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];
$itemid = $_POST['itemid'];

$sqldelete = "DELETE FROM CART WHERE EMAIL = '$email' AND ITEMID = '$itemid'";
if($conn->query($sqldelete) === TRUE){
    echo "success";
}else{
    echo "failed";
}
?>