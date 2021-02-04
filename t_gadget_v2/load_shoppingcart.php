<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];

//$sql = "SELECT * FROM CART WHERE EMAIL = '$email'";
$sql = "SELECT CART.ITEMID, CART.ITEMQUANTITY, CART.SELLERID, ITEM.NAME, ITEM.PICTURE, ITEM.PRICE FROM CART INNER JOIN ITEM ON CART.ITEMID = ITEM.ITEMID WHERE CART.EMAIL = '$email'";
$result = $conn->query($sql);
if($result->num_rows > 0){
    $response["cart"] = array();
    while ($row = $result -> fetch_assoc()){
        $cartlist = array();
        $cartlist[email] = $row["EMAIL"];
        $cartlist[itemid] = $row["ITEMID"];
        $cartlist[itemquantity] = $row["ITEMQUANTITY"];
        $cartlist[sellerid] = $row["SELLERID"];
        $cartlist[itemname] = $row["NAME"];
        $cartlist[itemprice] = $row["PRICE"];
        $cartlist[itempicture] = $row["PICTURE"];
        array_push($response["cart"],$cartlist);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>
