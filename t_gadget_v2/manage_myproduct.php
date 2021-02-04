<?php
error_reporting(0);
include_once("dbconnect.php");
$sellerid = $_POST['sellerid'];

$sql = "SELECT * FROM ITEM WHERE SELLERID = '$sellerid'";
$result = $conn->query($sql);
if($result->num_rows > 0){
    $response["product"] = array();
    while ($row = $result -> fetch_assoc()){
        $productlist = array();
        $productlist[itempicture] = $row["PICTURE"];
        $productlist[itemname] = $row["NAME"];
        $productlist[itemprice] = $row["PRICE"];
        $productlist[itemtype] = $row["TYPE"];
        $productlist[itemstatus] = $row["STATUS"];
        $productlist[itemlocation] = $row["LOCATION"];
        $productlist[itemdescription] = $row["DESCRIPTION"];
        $productlist[itemquantity] = $row["QUANTITY"];
        $productlist[uploaddate] = $row["DATEREG"];
        $productlist[itemid] = $row["ITEMID"];
        array_push($response["product"],$productlist);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>
