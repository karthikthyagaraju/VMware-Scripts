

$body = " This is a test mail to check the scheduling timing of the script "





Send-MailMessage  -from "Stealth Lab <StealthLab@unisys.com>"    -to "Sumeet.Panda@in.unisys.com"    -Subject "Test Mail"  -Body $body    -Cc "Vijay <vijay.verdia@unisys.com>"    -SmtpServer na-mailrelay-t3.na.uis.unisys.com  
 