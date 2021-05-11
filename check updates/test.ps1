#This will import list of servers from a csv
$servers= Import-Csv -Path C:\TEMP\Servers.csv

#This is to feed in the credentials for the servers
$username = "ap\tkarthi1"
$password = ConvertTo-SecureString “ByeUnisys2021” -AsPlainText -Force
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
    
    #Rows and Columns
    $o = new-object PSObject
    $o | add-member NoteProperty ServerName $VM.Name
    $o | add-member NoteProperty OperatingSystem $OS1
    $o | add-member NoteProperty LastBootTime $LastBootUpTime.LastBootUpTime
    $o | add-member NoteProperty UpTime $Uptime
    $o | add-member NoteProperty LastPatchedDate $LastPatchedDate.InstalledOn

        }

$o | export-csv "C:\temp\output.csv" -notypeinformation
#This is to export the automatic services that are not running
#$Output| Out-File -FilePath "C:\temp\output.csv" -Force


#This is to email the automatic services that are not running
$From = "Thyagaraju, Karthik <karthik.t2@in.unisys.com>"
$To = "Thyagaraju, Karthik <karthik.t2@in.unisys.com>"
$Cc = "Thyagaraju, Karthik <karthik.t2@in.unisys.com>"
$Date = ( get-date ).ToString('yyyy/MM/dd')
$Subject = "Remote servers patch update summary - $Date"
$SMTPServer = "NA-MAILRELAY-T3.na.uis.unisys.com"
$SMTPPort = "587"
$Body = "Hi Team, `n

Find the patching details attached`n

"
Send-MailMessage -From $From -To $To -CC $Cc -Subject $Subject -Body $Body -SmtpServer NA-MAILRELAY-T3.na.uis.unisys.com -Attachments "C:\temp\output.csv"