<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;

require 'src/Exception.php';
require 'src/PHPMailer.php';
require 'src/SMTP.php';

$mail = new PHPMailer(true);

include_once("dbconnect.php");
$name = $_POST['name'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$password = sha1($_POST['password']);
$otp = rand(1000,9999);

    //Server settings
    $mail->SMTPDebug = 2;                      
    $mail->isMail();                                           
    $mail->Host       = 'mail.triold.com';                    
    $mail->SMTPAuth   = true;                                   
    $mail->Username   = 'tgadget@triold.com';                     
    $mail->Password   = 'Teo169399';                              
    $mail->SMTPSecure = 'SSL';  //tls       
    $mail->Port       = 465;    //587                               

$sqlregister = "INSERT INTO USER(NAME,EMAIL,PHONE,PASSWORD,OTP) VALUES('$name','$email','$phone','$password','$otp')";

if ($conn->query($sqlregister) === TRUE){
    echo "success";
    $mail->setFrom('tgadget@triold.com', 'tgadget');
    $mail->addAddress($email, 'Receiver'); 
    $mail->isHTML(true);                                
    $mail->Subject = 'From Tgadget. Verify your account';
    $mail->Body    = "Welcome to T Gadget."."\u{1F603}"." Please use the following link to verify your account :"."\n http://triold.com/tgadget/php/verify_email.php?email=".$email."&key=".$otp;$email.'&key='.$otp;
    $mail->AltBody = 'This is the body in plain text for non-HTML mail clients';
    $mail->send();
}else{
    echo "failed";
}

   
   


   
//    echo 'Message has been sent';
//} catch (Exception $e) {
 //   echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
//}
