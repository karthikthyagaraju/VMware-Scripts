$file = import-csv "C:\Users\tkarthi1\OneDrive - Unisys\Scripts\bulkmail.csv"
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
               $body = " Hi $User1, <br>
               <br>
               <br>
               
               
               Your virtual machine(s) $Comp have reported an insufficient free disk space of less than 9%. <br>
               <br>

For your computer to function properly and safely, it requires a minimum amount of free disk space(>10% of OS Disk space), not only to properly handle the file system itself, but it also needs some disk space to be able to update virus definitions or to install service packs and security patches.
In addition to that, insufficient free disk space can cause a significant reduction in computer performance. 
<br>
<br>

Low disk space could also imply that the VM is not being utilized, so since we have a finite amount of storage resources in our virtual environment, we would also like to request you to review your requirements and decommission the VM if it is not being used. <br>

<br>
<br>

Please complete the following:<br>
a)	Visit the $link Self Help page and follow the instructions for freeing disk space on system drive.<br>
b)	If you need assistance on any of the above action items, please contact us by logging a ticket with TIS Server Support Que. <br>
c)  Please complete the above action at earliest to avoid from VMs getting disconnected.</b> <br>

<br>
<br>
<br>


Thank you, <br>
Karthik T| InTC  <br> "

#echo $comp

         #Send-MailMessage -To "$email"  -From "Thyagaraju, Karthik <karthik.t2@in.unisys.com>" -cc "sayan.saha@unisys.com","G, Alok <Alok.G@unisys.com>","ajay.kumtakar@unisys.com","karthik.t2@in.unisys.com" -Subject "Urgent Action Required - Low Disk Space " -Body $body -BodyAsHtml   -SmtpServer NA-MAILRELAY-T3.na.uis.unisys.com
         Send-MailMessage -To "karthik.t2@unisys.com"  -From "Thyagaraju, Karthik <karthik.t2@in.unisys.com>" -cc "rashmi.prakash@in.unisys.com","karthik.t2@in.unisys.com" -Subject "Urgent Security Action Required - Low Disk Space" -Body $body -BodyAsHtml   -SmtpServer NA-MAILRELAY-T3.na.uis.unisys.com
           echo "Sent mail to " $email " for following machines"    $comp           
           $comp = $null
           $comp1 = $null
        }
    
    }



