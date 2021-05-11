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

#Create excel COM object
$excel = New-Object -ComObject excel.application
$date = Get-Date -DisplayHint Date
#Make Visible
$excel.Visible = $True

#Add a workbook
$workbook = $excel.Workbooks.Add()

#Remove other worksheets
1..2 | ForEach {
    $Workbook.worksheets.item(2).Delete()
}

#Connect to first worksheet to rename and make active
$serverInfoSheet = $workbook.Worksheets.Item(1)
$serverInfoSheet.Name = 'DiskInformation'
$serverInfoSheet.Activate() | Out-Null

#Create a Title for the first worksheet and adjust the font
$row = 1
$Column = 1
$serverInfoSheet.Cells.Item($row,$column)= 'Server patching status'
$serverInfoSheet.Cells.Item($row,$column).Font.Size = 18
$serverInfoSheet.Cells.Item($row,$column).Font.Bold=$True
$serverInfoSheet.Cells.Item($row,$column).Font.Name = "Cambria"
$serverInfoSheet.Cells.Item($row,$column).Font.ThemeFont = 1
$serverInfoSheet.Cells.Item($row,$column).Font.ThemeColor = 4
$serverInfoSheet.Cells.Item($row,$column).Font.ColorIndex = 55
$serverInfoSheet.Cells.Item($row,$column).Font.Color = 8210719
$range = $serverInfoSheet.Range("a1","h2")
$range.Style = 'Title'
$range = $serverInfoSheet.Range("a1","g2")
$range.Merge() | Out-Null
$range.VerticalAlignment = -4160
$range | Get-Member -Name verticalalignment
[Enum]::getvalues([Microsoft.Office.Interop.Excel.XLVAlign]) | select @{n="Name";e={"$_"}},value__ 


#Increment row for next set of data
$row++;$row++
#Save the initial row so it can be used later to create a border
$initalRow = $row
#Create a header for Disk Space Report; set each cell to Bold and add a background color
$serverInfoSheet.Cells.Item($row,$column)= 'ServerName'
$serverInfoSheet.Cells.Item($row,$column).Interior.ColorIndex =48
$serverInfoSheet.Cells.Item($row,$column).Font.Bold=$True
$Column++
$serverInfoSheet.Cells.Item($row,$column)= 'OperatingSystem'
$serverInfoSheet.Cells.Item($row,$column).Interior.ColorIndex =48
$serverInfoSheet.Cells.Item($row,$column).Font.Bold=$True
$Column++
$serverInfoSheet.Cells.Item($row,$column)= 'PingStatus'
$serverInfoSheet.Cells.Item($row,$column).Interior.ColorIndex =48
$serverInfoSheet.Cells.Item($row,$column).Font.Bold=$True
$Column++
$serverInfoSheet.Cells.Item($row,$column)= 'Uptime'
$serverInfoSheet.Cells.Item($row,$column).Interior.ColorIndex =48
$serverInfoSheet.Cells.Item($row,$column).Font.Bold=$True
$Column++
$serverInfoSheet.Cells.Item($row,$column)= 'AutomaticServiceName'
$serverInfoSheet.Cells.Item($row,$column).Interior.ColorIndex =48
$serverInfoSheet.Cells.Item($row,$column).Font.Bold=$True
$Column++
$serverInfoSheet.Cells.Item($row,$column)= 'Startmode'
$serverInfoSheet.Cells.Item($row,$column).Interior.ColorIndex =48
$serverInfoSheet.Cells.Item($row,$column).Font.Bold=$True
$Column++
$serverInfoSheet.Cells.Item($row,$column)= 'Servicestate'
$serverInfoSheet.Cells.Item($row,$column).Interior.ColorIndex =48
$serverInfoSheet.Cells.Item($row,$column).Font.Bold=$True
$Column++
$serverInfoSheet.Cells.Item($row,$column)= 'LastPatched'
$serverInfoSheet.Cells.Item($row,$column).Interior.ColorIndex =48
$serverInfoSheet.Cells.Item($row,$column).Font.Bold=$True
$Column++
$serverInfoSheet.Cells.Item($row,$column)= 'LastBootUpTime'
$serverInfoSheet.Cells.Item($row,$column).Interior.ColorIndex =48
$serverInfoSheet.Cells.Item($row,$column).Font.Bold=$True

$row++
$Column = 1
    
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


#Increment Row and reset Column back to first column

$serverInfoSheet.Cells.Item($row,$column)= $VM.name
$Column++
$serverInfoSheet.Cells.Item($row,$column)= $OS1
$Column++
$serverInfoSheet.Cells.Item($row,$column)= $pingresult
$Column++
$serverInfoSheet.Cells.Item($row,$column)= $Uptime
$Column++
$serverInfoSheet.Cells.Item($row,$column)= $Automaticservices.DisplayName
$Column++
$serverInfoSheet.Cells.Item($row,$column)= $Automaticservicesmode.StartMode
$Column++
$serverInfoSheet.Cells.Item($row,$column)= $Automaticservices.State
$Column++
$serverInfoSheet.Cells.Item($row,$column)= $LastPatchedDate.InstalledOn
$Column++
$serverInfoSheet.Cells.Item($row,$column)= $LastBootUpTime.LastBootUpTime
$Column++
#Increment to next row and reset Column to 1
$Column = 1
$row++
}
$workbook.SaveAs("C:\temp\ServerPatchStatus.xlsx") 
#Quit the application
$excel.Quit()
#Release COM Object
[System.Runtime.InteropServices.Marshal]::ReleaseComObject([System.__ComObject]$excel) | Out-Null

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
Send-MailMessage -From $From -To $To -CC $Cc -Subject $Subject -Body $Body -SmtpServer NA-MAILRELAY-T3.na.uis.unisys.com -Attachments "C:\temp\ServerPatchStatus.xlsx"