$PW = (1..10)
$ascii=$NULL;For ($a=33;$a –le 126;$a++) {$ascii+=,[char][byte]$a }
     
 Function GET-Temppassword() {

Param(

[int]$length=8,

[string[]]$sourcedata

)

 

For ($loop=1; $loop –le $length; $loop++) {

            $TempPassword+=($sourcedata | GET-RANDOM)

            }

return $TempPassword

}

for($i=0;$i -lt 10; $i++)
{
  
  $PW[$i] = GET-Temppassword –length 8 –sourcedata $ascii   
     
}

#$body = $PW.ToString
#echo $body
$body = $PW | Out-String 

Send-MailMessage  -from "Stealth Lab <StealthLab@unisys.com>"    -to "Vijay <Vijay.Verdia@unisys.com>"    -Subject "Lab Credentials"  -Body $body    -Cc "Vijay <vijay.verdia@unisys.com>"    -SmtpServer na-mailrelay-t3.na.uis.unisys.com  
 