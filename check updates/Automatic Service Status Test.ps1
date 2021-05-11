#This will import list of servers from a csv
$servers= Import-Csv -Path "C:\TEMP\Servers.csv"

#This is to feed in the credentials for the servers
$username = "ap\tkarthi1"
$password = ConvertTo-SecureString “K@rtJAN2021” -AsPlainText -Force
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
    $Services =  Get-WmiObject Win32_Service -ComputerName $VM.Name -Credential $cred |
    Where-Object {($_.startmode -like "*auto*") -and ($Ignore -notcontains $_.DisplayName) -and ($_.state -notlike "*running*")}
    $Automaticservices =  $Services | Select DisplayName, Name, State
    $Automaticservicesmode = $Services | Select StartMode
    $OS = Get-WmiObject win32_operatingsystem -ComputerName $VM.Name -Credential $cred
    $OS1 = (Get-WmiObject win32_operatingsystem -ComputerName $VM.Name -Credential $cred).Caption 
    $LastBootUpTime = Get-CimInstance -ComputerName $VM.Name -Class CIM_OperatingSystem -ErrorAction Stop | Select-Object CSName, LastBootUpTime 
    $BootTime = $OS.ConvertToDateTime($OS.LastBootUpTime) 
    $UT = Get-WmiObject -ComputerName $VM.Name -Credential $cred win32_operatingsystem -ErrorAction SilentlyContinue
    $Display = (Get-Date) - ($UT.ConvertToDateTime($UT.lastbootuptime))
    $Uptime = "Up " + $Display.Days + " days, " + $Display.Hours + " hours, " + $Display.Minutes + " minutes"
    #$Uptime = Get-WmiObject Win32_OperatingSystem -ComputerName $VM.Name | Select-Object LastBootUpTime
    $LastPatchedDate = (Get-HotFix -ComputerName $VM.Name -credential $cred | sort installedon)[-1] | Select InstalledOn
    
    
    #Formatting the CSV
    $row = ''| Select VMName,OS,PingStatus,Uptime,AutomaticService,AutomaticServiceName,Startmode,Servicestate,LastPatched,LastBootUpTime
    $row.VMName = $VM.name
    $row.OS = $OS1
    $row.PingStatus = $pingresult
    $row.Uptime = $Uptime
    $row.AutomaticService = Write-Output $Automaticservices.Name
    $row.AutomaticServiceName = Write-Output $Automaticservices.DisplayName
    $row.Startmode = Write-Output $Automaticservicesmode.StartMode
    $row.Servicestate = Write-Output $Automaticservices.State
    $row.LastPatched = Write-Output $LastPatchedDate.InstalledOn
    $row.LastBootUpTime = Write-Output $LastBootUpTime.LastBootUpTime
    $output += $row
        }


#This is to export the automatic services that are not running
$Output| Out-File -FilePath "C:\temp\output.csv" -Force

#Define array
$Updates = @()
  
foreach ($VM in $servers)
{
#Checking updates in Software Center
Try{
    $Updates = Invoke-Command -cn $VM.Name {
        $Application =  Get-WmiObject -Namespace "root\ccm\clientsdk" -Class CCM_SoftwareUpdate 
        If(!$Application){
                $Object = New-Object PSObject -Property ([ordered]@{      
                        ArticleId         = " - "
                        Publisher         = " - "
                        Software          = " - "
                        Description       = " - "
                        State             = " - "
                        StartTime         = " - "
                        DeadLine          = " - "
                })
  
                $Object
        }
        Else{
            Foreach ($App in $Application){
  
                $EvState = Switch ( $App.EvaluationState  ) {
                        '0'  { "None" } 
                        '1'  { "Available" } 
                        '2'  { "Submitted" } 
                        '3'  { "Detecting" } 
                        '4'  { "PreDownload" } 
                        '5'  { "Downloading" } 
                        '6'  { "WaitInstall" } 
                        '7'  { "Installing" } 
                        '8'  { "PendingSoftReboot" } 
                        '9'  { "PendingHardReboot" } 
                        '10' { "WaitReboot" } 
                        '11' { "Verifying" } 
                        '12' { "InstallComplete" } 
                        '13' { "Error" } 
                        '14' { "WaitServiceWindow" } 
                        '15' { "WaitUserLogon" } 
                        '16' { "WaitUserLogoff" } 
                        '17' { "WaitJobUserLogon" } 
                        '18' { "WaitUserReconnect" } 
                        '19' { "PendingUserLogoff" } 
                        '20' { "PendingUpdate" } 
                        '21' { "WaitingRetry" } 
                        '22' { "WaitPresModeOff" } 
                        '23' { "WaitForOrchestration" } 
  
  
                        DEFAULT { "Unknown" }
                }
  
                $Object = New-Object PSObject -Property ([ordered]@{      
                        ArticleId         = $App.ArticleID
                        Publisher         = $App.Publisher
                        Software          = $App.Name
                        Description       = $App.Description
                        State             = $EvState
                        #StartTime         = Get-Date ([system.management.managementdatetimeconverter]::todatetime($($App.StartTime)))
                        #DeadLine          = Get-Date ([system.management.managementdatetimeconverter]::todatetime($($App.Deadline)))
                         
                })
  
                $Object
            }
        }
  
    } -ErrorAction Stop | select @{n='ServerName';e={$_.pscomputername}},ArticleID,Publisher,Software,Description,State #StartTime,DeadLine
}
Catch [System.Exception]{
    Write-Host "Error" -BackgroundColor Red -ForegroundColor Yellow
    $_.Exception.Message
}
  
#Display results
#$Updates | Out-GridView -Title "Updates" 
 
#Export results to CSV
$Updates | Export-Csv "C:\temp\missing_updates.csv" -Force -NoTypeInformation
}


#This is to email the automatic services that are not running
$From = "Thyagaraju, Karthik <karthik.t2@in.unisys.com>"
$To = "Thyagaraju, Karthik <karthik.t2@in.unisys.com>"
$Cc = "Thyagaraju, Karthik <karthik.t2@in.unisys.com>"
$Date = ( get-date ).ToString('yyyy/MM/dd')
$Subject = "Remote servers patch update summary - $Date"
$SMTPServer = "NA-MAILRELAY-T3.na.uis.unisys.com"
$SMTPPort = "587"
$Out = $Output | Out-String
$Body = "Hi Team, `n

Find the patching details below. PFA the details as well. `n

$Out


"

Send-MailMessage -From $From -To $To -CC $Cc -Subject $Subject -Body $Body -SmtpServer NA-MAILRELAY-T3.na.uis.unisys.com -Attachments "C:\temp\output.csv", "C:\temp\missing_updates.csv"

