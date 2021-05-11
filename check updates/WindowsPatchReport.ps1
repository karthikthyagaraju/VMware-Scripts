#This will import list of servers from a csv
$servers= Import-Csv -Path "C:\TEMP\Servers.csv"

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
    'Google Update Service (gupdate)'
    'Google Update Service (gupdatem)'
    'Diagnostic Policy Service'; 
) 

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
    $Services =  Get-WmiObject Win32_Service -ComputerName $VM.Name -Credential $cred |
    Where-Object {($_.startmode -like "*auto*") -and ($Ignore -notcontains $_.DisplayName) -and ($_.state -notlike "*running*")}
    $Automaticservices =  $Services | Select DisplayName, Name, State
    $AS = Write-Output $Automaticservices
    $Automaticservicesmode = $Services | Select StartMode
    $ASM = Write-Output $Automaticservicesmode
    $OS = Get-WmiObject win32_operatingsystem -ComputerName $VM.Name -Credential $cred
    $OS1 = (Get-WmiObject win32_operatingsystem -ComputerName $VM.Name -Credential $cred).Caption
    $LastBootUpTime = Get-CimInstance -ComputerName $VM.Name -Class CIM_OperatingSystem -ErrorAction Stop | Select-Object CSName, LastBootUpTime 
    $BootTime = $OS.ConvertToDateTime($OS.LastBootUpTime) 
    $UT = Get-WmiObject -ComputerName $VM.Name -Credential $cred win32_operatingsystem -ErrorAction SilentlyContinue
    $Display = (Get-Date) - ($UT.ConvertToDateTime($UT.lastbootuptime))
    $Uptime = "Up " + $Display.Days + " days, " + $Display.Hours + " hours, " + $Display.Minutes + " minutes"
    #$Uptime = Get-WmiObject Win32_OperatingSystem -ComputerName $VM.Name | Select-Object LastBootUpTime
    $LastPatchedDate = (Get-HotFix -ComputerName $VM.Name -credential $cred | sort installedon)[-1] | Select InstalledOn

$o = new-object PSObject
$o | add-member NoteProperty ServerName $VM.Name
#$o | add-member NoteProperty AutoServices $AS.Name -Force
#$o | add-member NoteProperty AutoServicesMode $ASM.StartMode -Force
$o | add-member NoteProperty OperatingSystem $OS1
$o | add-member NoteProperty LastBootTime $LastBootUpTime.LastBootUpTime
$o | add-member NoteProperty UpTime $Uptime
$o | add-member NoteProperty LastPatchedDate $LastPatchedDate.InstalledOn
$output += $o

}
$o | export-csv "C:\temp\output.csv" -notypeinformation

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