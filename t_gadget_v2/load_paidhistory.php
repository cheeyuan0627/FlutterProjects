<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];

$sql = "SELECT * FROM PAID WHERE EMAIL = '$email'";
$result = $conn->query($sql);
if($result->num_rows > 0){
    $response["paid"] = array();
    while ($row = $result -> fetch_assoc()){
        $paidlist = array();
        $paidlist[receiptid] = $row["RECEIPTID"];
        $paidlist[date] = $row["DATE"];
        $paidlist[amount] = $row["AMOUNT"];
        array_push($response["paid"],$paidlist);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>