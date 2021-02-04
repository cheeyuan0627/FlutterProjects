<?php
error_reporting(0);
include_once("dbconnect.php");
$sellerid = $_POST['sellerid'];
$itemid = $_POST['itemid'];

$sqldelete = "DELETE FROM ITEM WHERE SELLERID = '$sellerid' AND ITEMID = '$itemid'";
if($conn->query($sqldelete) === TRUE){
    echo "success";
}else{
    echo "failed";
}
?>