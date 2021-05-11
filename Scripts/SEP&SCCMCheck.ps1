
add-pssnapin vmware.vimautomation.core
Connect-VIServer 172.22.242.26 -User gtci-dev\sahasaya -Password Bloodline@11

$xlCSV = 6
$xlXLS = 56
$csvfile = "compliance.csv"
$xlsfile = "compliance.xls"

$Excel = New-Object -ComObject Excel.Application
$Excel.visible = $True
$Excel = $Excel.Workbooks.Add()
 
$Sheet = $Excel.Worksheets.Item(1)
$Sheet.Cells.Item(1,1) = "VMSkinName"
$Sheet.Cells.Item(1,2) = "VMHostName"
$Sheet.Cells.Item(1,3) = "GuestOSVersion"
$Sheet.Cells.Item(1,4) = "ServerStatus"
$Sheet.Cells.Item(1,5) = "SEPVersion"
$Sheet.Cells.Item(1,6) = "SEPCompliance"
$Sheet.Cells.Item(1,7) = "SCCMVersion"
$Sheet.Cells.Item(1,8) = "SCCMStatus"


$intRow = 2

$WorkBook = $Sheet.UsedRange
$WorkBook.Interior.ColorIndex = 19
$WorkBook.Font.ColorIndex = 11
$WorkBook.Font.Bold = $True

$compliant = "Compliant"
$notcompliant = "Not Compliant"
$unknown = "Unknown Status"
$running = "Running"
$notrunning = "Not Running"

$username = "ap\sahasaya"
$password = ConvertTo-SecureString “Bloodline@11” -AsPlainText -Force
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $password

$servers= get-vm -Location "GTCI-Virtual"

foreach ($server in $servers)

{

$service = $Null
$RegKey = $Null
$SEPVersion = $Null
$pingtest = $Null
$serveravailability = $Null
$WMIFirewall = $Null


echo $server.Name
$VM = get-vm $server.Name -ErrorAction SilentlyContinue
    <#if($VM.Guest.HostName -eq $null) {$serveravailability = "Server Does Not Exist"}
    else {echo $VM.Guest.HostName}
echo $serveravailability#>

$pingtest = Test-Connection -ComputerName $VM.Guest.HostName -Count 2 -ErrorAction SilentlyContinue
    if($pingtest -eq $null)
      {$pingresult = "Server Down"}
    else
      {$pingresult = "Server Up"}
echo $pingresult

$service = Get-WmiObject Win32_Service -Filter "Name = 'RemoteRegistry'" -ComputerName $VM.Guest.HostName -credential $cred -ErrorAction SilentlyContinue
$service.ChangeStartMode("Automatic")
Start-Sleep -s 5
$service.StartService()
Start-Sleep -s 5

trap [Exception] {continue}

$Reg = $Null
$Reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $VM.Guest.HostName)
$RegKey1 = $Null
$RegKey1= $Reg.OpenSubKey("SOFTWARE\\Symantec\\Symantec Endpoint Protection\\CurrentVersion")
$RegKey2 = $Null
$RegKey2= $Reg.OpenSubKey("SOFTWARE\\Symantec\\Symantec Endpoint Protection\\SMC")
$SEPVersion1 = $Null
$SEPVersion1 = $RegKey1.GetValue("PRODUCTVERSION")
$SEPVersion2 = $Null
$SEPVersion2 = $RegKey2.GetValue('ProductVersion')


If($SEPVersion1 -eq $null) 
    {$SEPVersion = $SEPVersion2} 
else
    {$SEPVersion = $SEPVersion1}
echo $SEPVersion2

if($pingtest -eq $null)
    {$SEPVersion = $Null}

$SCCMVersion = $Null
$SCCMVersion = Get-WmiObject -NameSpace Root\CCM -Class Sms_Client -ComputerName $VM.Guest.HostName -credential $cred
echo $SCCMVersion.ClientVersion

$SCCMStatus = $Null
$SCCMStatus = Get-WmiObject Win32_Service -Filter "Name = 'CcmExec'" -ComputerName $VM.Guest.HostName -credential $cred -ErrorAction SilentlyContinue
echo $SCCMStatus.State

trap [Exception] {continue}


$Sheet.Cells.Item($intRow, 1) = $server.Name
$Sheet.Cells.Item($intRow, 2) = $VM.Guest.HostName
$Sheet.Cells.Item($intRow, 3) = $VM.Guest.OSFullName
$Sheet.Cells.Item($intRow, 4) = $pingresult
$Sheet.Cells.Item($intRow, 5) = [String]$SEPVersion
$Sheet.Cells.Item($intRow, 7) = [String]$SCCMVersion.ClientVersion


If($SEPVersion -lt 14 -and $SEPVersion -gt 1)
    {
    $Sheet.Cells.Item($intRow, 6) = [String]$notcompliant
    $Sheet.Cells.Item($intRow, 6).Interior.ColorIndex = 3
     }
elseif($SEPVersion -gt 14)
    {
    $Sheet.Cells.Item($intRow, 6) = [String]$compliant
    $Sheet.Cells.Item($intRow, 6).Interior.ColorIndex = 4
     }
elseif($SEPVersion -eq $Null)
    {
    $Sheet.Cells.Item($intRow, 6) = [String]$unknown
    $Sheet.Cells.Item($intRow, 6).Interior.ColorIndex = 48
     }

If($SCCMStatus.State -eq "Running")
    {
    $Sheet.Cells.Item($intRow, 8) = [String]$running
    $Sheet.Cells.Item($intRow, 8).Interior.ColorIndex = 4
    }
elseif($SCCMStatus.State -eq "Stopped")
    {
    $Sheet.Cells.Item($intRow, 8) = [String]$notrunning
    $Sheet.Cells.Item($intRow, 8).Interior.ColorIndex = 3
    }
elseif($SCCMStatus.State -eq $Null)
    {
    $Sheet.Cells.Item($intRow, 8) = [String]$unknown
    $Sheet.Cells.Item($intRow, 8).Interior.ColorIndex = 48
    }
$intRow = $intRow + 1
}

$WorkBook.EntireColumn.AutoFit()

sleep 5
 
$Sheet.SaveAs($xlsfile,$xlXLS)
$Sheet.SaveAs($csvfile,$xlCSV)