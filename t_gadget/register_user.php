<?
include_once("dbconnect.php");
$name = $_POST['name'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$password = sha1($_POST['password']);
$otp = rand(1000,9999);

$sqlregister = "INSERT INTO USER(NAME,EMAIL,PHONE,PASSWORD,OTP) VALUES('$name','$email','$phone','$password','$otp')";

if($conn->query($sqlregister) === TRUE){
    sendEmail($otp,$email);
    echo "success";
}else{
    echo "failed";
}

function sendEmail($otp,$email){
    $from = "noreply@tgadget.com";
    $to = $email;
    $subject = "From T Gadget. Verify your account";
    $message = "Welcome to T Gadget."."\u{1F603}"." Please use the following link to verify your account :"."\n http://triold.com/tgadget/php/verify_email.php?email=".$email."&key=".$otp;
    $headers = "From:" . $from;
    mail($email,$subject,$message,$headers);
}
?>