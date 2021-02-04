<?php
$servername = "localhost";
$username   = "trioldco_tgadgetadmin";
$password   = "Teo169399";
$dbname     = "trioldco_tgadget";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error){
    die("Connection failed: " . $conn->connect_error);
}
?>