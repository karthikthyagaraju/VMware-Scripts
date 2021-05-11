#This will import list of servers from a csv
$servers = gc "C:\TEMP\servers.txt"

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
foreach ($VM in $servers){

   {
    $Services =  Get-WmiObject Win32_Service -ComputerName $VM -Credential $cred |
    Where-Object {($_.startmode -like "*auto*") -and ($Ignore -notcontains $_.DisplayName) -and ($_.state -notlike "*running*")} }
    $Automaticservices =  $Services | Select DisplayName, Name, State
    $Automaticservicesmode = $Services | Select StartMode
    $OS = Get-WmiObject win32_operatingsystem -ComputerName $VM -Credential $cred
    $OS1 = (Get-WmiObject win32_operatingsystem -ComputerName $VM -Credential $cred).Caption
    $LastBootUpTime = Get-CimInstance -ComputerName $VM -Class CIM_OperatingSystem -ErrorAction Stop | Select-Object CSName, LastBootUpTime 
    $BootTime = $OS.ConvertToDateTime($OS.LastBootUpTime) 
    $UT = Get-WmiObject -ComputerName $VM -Credential $cred win32_operatingsystem -ErrorAction SilentlyContinue
    $Display = (Get-Date) - ($UT.ConvertToDateTime($UT.lastbootuptime))
    $Uptime = "Up " + $Display.Days + " days, " + $Display.Hours + " hours, " + $Display.Minutes + " minutes"
    #$Uptime = Get-WmiObject Win32_OperatingSystem -ComputerName $VM.Name | Select-Object LastBootUpTime
    $LastPatchedDate = (Get-HotFix -ComputerName $VM -credential $cred | sort installedon)[-1] | Select InstalledOn
    
    
    #Formatting the CSV
    $row = ''| Select VMName,OS,PingStatus,Uptime,AutomaticService,AutomaticServiceName,Startmode,Servicestate,LastPatched,LastBootUpTime
    $row.VMName = $VM
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
