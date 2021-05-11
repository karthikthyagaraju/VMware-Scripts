#This will import list of servers from a csv
$servers= Import-Csv -Path C:\Scripts\patchingvm.csv

#This is to feed in the credentials for the servers
$username = "na\sa_ustr_scom"
$password = ConvertTo-SecureString “scom*Unisys” -AsPlainText -Force
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $password

#This is the automatic services list that needs to be ignored like automatic delayed services
$Ignore=@( 
    'Microsoft .NET Framework NGEN v4.0.30319_X64', 
    'Microsoft .NET Framework NGEN v4.0.30319_X86', 
    'Multimedia Class Scheduler', 
    'Performance Logs and Alerts', 
    'SBSD Security Center Service', 
    'Shell Hardware Detection', 
    'Software Protection', 
    'TPM Base Services',
    'User Access Logging Service'
    'Distributed Transaction Coordinator'
    'Group Policy Client'
    'Remote Registry'
    'TCP/IP NetBIOS Helper'
    'IKE and AuthIP IPsec Keying Modules'
    'Diagnostic Policy Service'; 
) 

#This is to check the automatic services that are not running except the services in the Ignore List
$Output=@()
foreach ($VM in $servers)

   {
    #Creating column values
    $pingtest = Test-Connection -ComputerName $VM.Name -Count 2 -ErrorAction SilentlyContinue
    if($pingtest -eq $null)
      {
       $pingresult = "Server is down"
      }
    else
      {
       $pingresult = "Server is up"
      }
    $Services =  Get-WmiObject Win32_Service -ComputerName $VM.Name -credential $cred |
    Where-Object {($_.startmode -like "*auto*") -and ($Ignore -notcontains $_.DisplayName) -and ($_.state -notlike "*running*")}
    $Automaticservices =  $Services | Select DisplayName
    $Automaticservicesmode = $Services | Select StartMode
    $Automaticservicesstate = $Services | Select State
    $OS = Get-WmiObject win32_operatingsystem -ComputerName $VM.name -Credential $cred
    $BootTime = $OS.ConvertToDateTime($OS.LastBootUpTime) 
    $Uptime = $OS.ConvertToDateTime($OS.LocalDateTime) - $boottime
    $LastPatchedDate = (Get-HotFix -ComputerName $VM.Name -credential $cred | sort installedon)[-1] | Select InstalledOn
    

    #Formatting the CSV
    $row = ''| Select VMName,PingStatus,Uptime,AutomaticService,Startmode,Servicestate,LastPatched
    $row.VMName = $VM.name
    $row.PingStatus = $pingresult
    $row.Uptime = $Uptime
    $row.AutomaticService = $Automaticservices
    $row.Startmode = $Automaticservicesmode
    $row.Servicestate = $Automaticservicesstate
    $row.LastPatched = $LastPatchedDate
    $output += $row
        }


#This is to export the automatic services that are not running
$Output| Out-File -FilePath "C:\temp\output.csv" -Force


#This is to email the automatic services that are not running
$From = "Saha, Sayan < sayan.saha@in.unisys.com >"
$To = "Saha, Sayan < sayan.saha@in.unisys.com>"
$Cc = "sayan.saha@in.unisys.com"
$Date = ( get-date ).ToString('yyyy/MM/dd')
$Subject = "Automatic Service Status - $Date"
$SMTPServer = "NA-MAILRELAY-T3.na.uis.unisys.com"
$SMTPPort = "587"
$Out = $Output | Out-String
$Body = "Hi Team, `n

Find the patching details below. PFA the details as well. `n

$Out


Thanks and Regards,

Sayan Saha
Microsoft® Certified IT Professional | ITIL V3 Foundation | System Analyst | TIS-InTC 
Unisys Global Services - India | Purva Premier No.135/1, Residency Road | Bangalore 560025 | Direct Phone: +91 080 41595943 | Net Phone: 7595943 | Mobile phone: +91 9663884091 | Email: sayan.saha@in.unisys.com
 

THIS COMMUNICATION MAY CONTAIN CONFIDENTIAL AND/OR OTHERWISE PROPRIETARY MATERIAL and is for use only by the intended recipient. If you received this in error, please contact the sender and delete the e-mail and its attachments from all devices.


"

Send-MailMessage -From $From -To $To -CC $Cc -Subject $Subject -Body $Body -SmtpServer NA-MAILRELAY-T3.na.uis.unisys.com -Attachments "C:\temp\output.csv"

