$file = import-csv "C:\Users\tkarthi1\Desktop\bulkmail.csv"
$link = "<a href='http://riskmanagement.unisys.com/selfhelp/howto/FreeUpDiskSpace.htm'>How to free-up space on your hard disk</a>"
$comp = $null
$comp1 = $null
$Array = @()
$Array = $file 
$len = $Array.Count
for($i=0; $i -le $len; $i++)

    {
      
     if($Array[$i].UserName -eq $Array[$i+1].UserName)
        {
        $comp1 = $Array[$i].Name
        $comp = (-join ("$comp1", ",", " $comp "))
        #echo $comp

        }

    else
        {
            $comp1 = $Array[$i].Name
            $comp = (-join ("$comp1", ",", " $comp"))
           $email =  $Array[$i].UserName

           $user = $email.split(".")
           $User1 = $user[0]
           $User1 = $User1.substring(0,1).toupper()+$User1.substring(1).tolower()
           $attachment = "C:\Users\tkarthi1\Desktop\January 2020 - Microsoft Security Patches - Immediate Action Required.msg"
           $smtpserver = "NA-MAILRELAY-T3.na.uis.unisys.com"
           
               $body = " Hi $User1, <br>
               <br>
               
               
               
               With respect to the attached communication, it has been reported that the below windows VM which you own is still not compliant. <br>
               We request you to take immediate action by following the instructions mentioned in the attached mail to avoid any non-compliant report reaching to the higher management and  eventually lead to VM termination. <br>
               <br>



VM Name(s) : $comp

<br>
<br>


Thanks and Regards, <br>
Technology Infrastructure Team  <br> "

$attach = new-object Net.Mail.Attachment($attachment) 
#echo $comp

         #Send-MailMessage -To "$email"  -From "Thyagaraju, Karthik <karthik.t2@in.unisys.com>" -cc "sayan.saha@unisys.com","G, Alok <Alok.G@unisys.com>","ajay.kumtakar@unisys.com","karthik.t2@in.unisys.com" -Subject "Urgent Action Required - Low Disk Space " -Body $body -BodyAsHtml   -SmtpServer NA-MAILRELAY-T3.na.uis.unisys.com
         $message = new-object System.Net.Mail.MailMessage 
         $message.From = "Thyagaraju, Karthik <karthik.t2@in.unisys.com>" 
         $message.To.Add($email) 
         $message.CC.Add("rashmi.prakash@in.unisys.com") 
         $message.CC.Add("karthik.t2@unisys.com")
         $message.IsBodyHtml = $True 
         $message.Subject = "January 2020 - Microsoft Security Patches - Immediate Action Required- Reminder-1" 
         $attach = new-object Net.Mail.Attachment($attachment)
         $message.Attachments.Add($attach) 
         $message.body = $body 
         $smtp = new-object Net.Mail.SmtpClient($smtpserver) 
         $smtp.Send($message) 

         #Send-MailMessage -To "karthik.t2@unisys.com"  -From "Thyagaraju, Karthik <karthik.t2@in.unisys.com>" -cc "karthik.t2@in.unisys.com" -Subject "January 2020 - Microsoft Security Patches - Immediate Action Required- Reminder-1" -Body $body -BodyAsHtml   -SmtpServer NA-MAILRELAY-T3.na.uis.unisys.com
          # echo "Sent mail to " $email " for following machines"    $comp           
           $comp = $null
           $comp1 = $null
        }
    
    }



