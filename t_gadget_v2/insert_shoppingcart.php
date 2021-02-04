<?php
include_once("dbconnect.php");
$email = $_POST['email'];
$itemid = $_POST['itemid'];
$itemquantity = $_POST['itemquantity'];
$sellerid = $_POST['sellerid'];

$sqlcheck = "SELECT * FROM CART WHERE ITEMID = '$itemid' AND EMAIL = '$email'";
$result = $conn->query($sqlcheck);
if($result->num_rows >0){
    $sqlupdate ="UPDATE CART SET ITEMQUANTITY = '$itemquantity' WHERE ITEMID = '$itemid' AND EMAIL = '$email'";
    if ($conn->query($sqlupdate) === TRUE){
        echo "success";
    }
}
else{
    $sqlinsert= "INSERT INTO CART(EMAIL,ITEMID,ITEMQUANTITY,SELLERID) VALUES('$email','$itemid','$itemquantity','$sellerid')";
    if($conn->query($sqlinsert) === TRUE){
     echo "success";
}else{
    echo "failed";
}}
?>