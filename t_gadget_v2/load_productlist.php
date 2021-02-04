<?php
error_reporting(0);
include_once("dbconnect.php");


if(isset($_POST['itemtype'])){
    $itemtype = $_POST['itemtype'];
    $sql= "SELECT * FROM ITEM WHERE TYPE = '$itemtype'";
}else{
    $sql = "SELECT * FROM ITEM ";
}
$result = $conn->query($sql);

if($result->num_rows > 0){
    $response["item"] = array();
    while ($row = $result -> fetch_assoc()){
        $itemlist = array();
        $itemlist[itempicture] = $row["PICTURE"];
        $itemlist[itemname] = $row["NAME"];
        $itemlist[itemprice] = $row["PRICE"];
        $itemlist[itemtype] = $row["TYPE"];
        $itemlist[itemstatus] = $row["STATUS"];
        $itemlist[itemlocation] = $row["LOCATION"];
        $itemlist[itemdescription] = $row["DESCRIPTION"];
        $itemlist[itemquantity] = $row["QUANTITY"];
        $itemlist[itemid] = $row["ITEMID"];
        $itemlist[sellerid] = $row["SELLERID"];
        array_push($response["item"],$itemlist);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}