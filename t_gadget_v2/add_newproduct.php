<?php
include_once("dbconnect.php");
$itemname = $_POST['itemname'];
$itemprice = $_POST['itemprice'];
$itemtype = $_POST['itemtype'];
$itemstatus = $_POST['itemstatus'];
$itemlocation = $_POST['itemlocation'];
$itemdescription = $_POST['itemdescription'];
$itemquantity = $_POST['itemquantity'];
$itempicture = $_POST['itempicture'];
$itemid = $_POST['itemid'];
$sellerid = $_POST['sellerid'];
$encoded_string = $_POST["encoded_string"];
$decoded_string = base64_decode($encoded_string);
$path = '../images/itempictures/'.$itempicture.'.png';
$is_written = file_put_contents($path,$decoded_string);

if($is_written > 0){
    $sqladd = "INSERT INTO ITEM(NAME,PRICE,TYPE,STATUS,LOCATION,DESCRIPTION,QUANTITY,PICTURE,ITEMID,SELLERID) VALUES('$itemname','$itemprice','$itemtype','$itemstatus','$itemlocation','$itemdescription','$itemquantity','$itempicture','$itemid','$sellerid')";
    if($conn->query($sqladd) === TRUE){
    echo "success";
}else{
    echo "failed";
}
}
?>