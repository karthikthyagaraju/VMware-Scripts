﻿##Setting Secure Credentials##
$username1 = "gtci-dev\sahasaya"
$username2 = "ap\sahasaya"
$password = Get-Content C:\scripts\Sayan_encryptedpassword.txt | ConvertTo-SecureString
$credgtci = new-object -typename System.Management.Automation.PSCredential -argumentlist $username1, $password
$credap = new-object -typename System.Management.Automation.PSCredential -argumentlist $username2, $password


##Connect to vCenter Server##
#add-pssnapin vmware.vimautomation.core
Connect-VIServer 172.22.242.26 -Credential $credgtci

##This will create the excel report file and set the rows and columns## 
$xlXLS = 56
$date =  (get-date).ToString('ddMMyyyy')
$xlsfile = -join( "C:\Scripts\SEP&SCCMCheck\Compliance Report\Compliance Report-", $date, ".xls" ) 

$Excel = New-Object -ComObject Excel.Application
$Excel.visible = $False
$Workbook = $Excel.Workbooks.Add()
 
$Sheet = $Workbook.Worksheets.Item(1)
$Sheet.Cells.Item(1,1) = "VMSkinName"
$Sheet.Cells.Item(1,2) = "VMHostName"
$Sheet.Cells.Item(1,3) = "GuestOSVersion"
$Sheet.Cells.Item(1,4) = "ServerStatus"
$Sheet.Cells.Item(1,5) = "SEPVersion"
$Sheet.Cells.Item(1,6) = "SEPCompliance"
$Sheet.Cells.Item(1,7) = "SCCMVersion"
$Sheet.Cells.Item(1,8) = "SCCMStatus"


$intRow = 2

$UsedRange = $Sheet.UsedRange
$UsedRange.Interior.ColorIndex = 19
$UsedRange.Font.ColorIndex = 11
$UsedRange.Font.Bold = $True

$compliant = "Compliant"
$notcompliant = "Not Compliant"
$unknown = "Unknown Status"
$running = "Running"
$notrunning = "Not Running"

##This is to fetch the required VMs from vCenter. Please set "Location" parameter according to requirement. For Ex: Any ESX hostname or Any Clustername from vCenter## 
$servers= get-vm -Location "GTCI-VIRTUAL"


##Starting loop which will run on each VM in the ESX host or Cluster##
foreach ($server in $servers)

{

##setting VM details in variable##
echo $server.Name
$VM = get-vm $server.Name -ErrorAction SilentlyContinue
$FQDN = $Null
$FQDN = $VM.Guest.HostName
echo $FQDN
$Domain = $Null
$Domain = $FQDN -split '\.'
$DomainName = $Null
$DomainName = $Domain[1..($Domain.Count)] -Join '.'
$VMIP = $Null
$VMIP = $VM.guest.IPAddress | Sort-Object -Descending |Select-Object -Last 1

$Username3 = "$FQDN\administrator"
$Password3 = "Welcome1"
$Pass3 = $Password3 | ConvertTo-SecureString -AsPlainText -Force
$credadmin = new-object -typename System.Management.Automation.PSCredential -argumentlist $username3, $Pass3

#####################################################################################################################
#####################################################################################################################
##Ping test on the VM##

$pingtest = $Null
$pingresult = $Null
$pingtest = Test-Connection -ComputerName $FQDN -Count 2 -ErrorAction SilentlyContinue
    if($pingtest -eq $null)
      {$pingresult = "Server Down"}
    else
      {$pingresult = "Server Up"}
echo $pingresult

trap [Exception] {continue}


#####################################################################################################################
#####################################################################################################################
##SEP Version Check##

If($pingresult -eq "Server Up" -and $VM.Guest.OSFullName -like "Microsoft*")
{

If($DomainName -eq "GTCI-DEV.COM")
{
$Var = $Null
$Var1 = $Null
$Var2 = $Null
$SEP = $Null
$SEPVersion = $Null
$uncServer = "\\$FQDN"


net use $uncServer $password /USER:$username1 

$Var1 = get-childitem "\\$FQDN\c$\Program Files (x86)\Symantec\Symantec Endpoint Protection"
trap [Exception] {continue}
$Var2 = get-childitem "\\$FQDN\c$\Program Files\Symantec\Symantec Endpoint Protection"
trap [Exception] {continue}

If($Var1 -eq $null) 
    {$Var = $Var2} 
else
    {$Var = $Var1}

$SEP = $Var | Where-Object{($_.Mode -eq "d-----") -or ($_.Mode -eq "da----")} | Sort-Object -Descending Name | Select-Object -First 1
$SEPVersion = $SEP.Name

echo $SEPVersion

    If($SEPVersion -eq $Null)
        {
        $Var = $Null
        $Var1 = $Null
        $Var2 = $Null
        $SEP = $Null
        $SEPVersion = $Null
        $uncServer = "\\$VMIP"

        net use $uncServer $password /USER:$username1

        $Var1 = get-childitem "\\$VMIP\c$\Program Files (x86)\Symantec\Symantec Endpoint Protection"
        trap [Exception] {continue}
        $Var2 = get-childitem "\\$VMIP\c$\Program Files\Symantec\Symantec Endpoint Protection"
        trap [Exception] {continue}

        If($Var1 -eq $null) 
            {$Var = $Var2} 
        else
            {$Var = $Var1}

        $SEP = $Var | Where-Object{($_.Mode -eq "d-----") -or ($_.Mode -eq "da----")} | Sort-Object -Descending Name | Select-Object -First 1
        $SEPVersion = $SEP.Name

        echo $SEPVersion
        }
}


Elseif($DomainName -eq "eu.uis.unisys.com")
{
$Var = $Null
$Var1 = $Null
$Var2 = $Null
$SEP = $Null
$SEPVersion = $Null


$Var1 = get-childitem "\\$FQDN\c$\Program Files (x86)\Symantec\Symantec Endpoint Protection"
trap [Exception] {continue}
$Var2 = get-childitem "\\$FQDN\c$\Program Files\Symantec\Symantec Endpoint Protection"
trap [Exception] {continue}

If($Var1 -eq $null) 
    {$Var = $Var2} 
else
    {$Var = $Var1}

$SEP = $Var | Where-Object{($_.Mode -eq "d-----") -or ($_.Mode -eq "da----")} | Sort-Object -Descending Name | Select-Object -First 1
$SEPVersion = $SEP.Name
echo $SEPVersion
}


Else
{
$Var = $Null
$Var1 = $Null
$Var2 = $Null
$SEP = $Null
$SEPVersion = $Null
$uncServer = "\\$FQDN"

$Username3 = "$FQDN\administrator"
$Password2 = "Welcome1"

net use $uncServer $password3 /USER:$username3

$Var1 = get-childitem "\\$FQDN\c$\Program Files (x86)\Symantec\Symantec Endpoint Protection"
trap [Exception] {continue}
$Var2 = get-childitem "\\$FQDN\c$\Program Files\Symantec\Symantec Endpoint Protection"
trap [Exception] {continue}

If($Var1 -eq $null) 
    {$Var = $Var2} 
else
    {$Var = $Var1}

$SEP = $Var | Where-Object{($_.Mode -eq "d-----") -or ($_.Mode -eq "da----")} | Sort-Object -Descending Name | Select-Object -First 1
$SEPVersion = $SEP.Name

echo $SEPVersion
}


If($SEPVersion -eq $Null)
{
$Var = $Null
$Var1 = $Null
$Var2 = $Null
$SEP = $Null
$SEPVersion = $Null
$uncServer = "\\$VMIP"

$Username3 = "$FQDN\administrator"
$Password2 = "Welcome1"

net use $uncServer $password3 /USER:$username3

$Var1 = get-childitem "\\$VMIP\c$\Program Files (x86)\Symantec\Symantec Endpoint Protection"
trap [Exception] {continue}
$Var2 = get-childitem "\\$VMIP\c$\Program Files\Symantec\Symantec Endpoint Protection"
trap [Exception] {continue}

If($Var1 -eq $null) 
    {$Var = $Var2} 
else
    {$Var = $Var1}

$SEP = $Var | Where-Object{($_.Mode -eq "d-----") -or ($_.Mode -eq "da----")} | Sort-Object -Descending Name | Select-Object -First 1
$SEPVersion = $SEP.Name

echo $SEPVersion
}

#####################################################################################################################
#####################################################################################################################

$SCCMVersion = $Null
$SCCMVersion = Get-WmiObject -NameSpace Root\CCM -Class Sms_Client -ComputerName $VM.Guest.HostName -credential $credap
echo $SCCMVersion.ClientVersion

If($SCCMVersion.ClientVersion -eq $Null)
{
$SCCMVersion = Get-WmiObject -NameSpace Root\CCM -Class Sms_Client -ComputerName $VM.Guest.HostName -credential $credadmin
echo $SCCMVersion.ClientVersion
}

$SCCMStatus = $Null
$SCCMStatus = Get-WmiObject Win32_Service -Filter "Name = 'CcmExec'" -ComputerName $VM.Guest.HostName -credential $credap -ErrorAction SilentlyContinue
echo $SCCMStatus.State

If($SCCMStatus.State -eq $Null)
{
$SCCMStatus = Get-WmiObject Win32_Service -Filter "Name = 'CcmExec'" -ComputerName $VM.Guest.HostName -credential $credadmin -ErrorAction SilentlyContinue
echo $SCCMStatus.State
}

trap [Exception] {continue}

}


Else
{
$SCCMStatus = $Null
$SEPVersion = $Null
}

#####################################################################################################################
#####################################################################################################################
##Assigning Values to the excel report##


$Sheet.Cells.Item($intRow, 1) = $server.Name
$Sheet.Cells.Item($intRow, 2) = $FQDN
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

##End of Loop##
}

$UsedRange.EntireColumn.AutoFit()

sleep 5

##This will save the excel in XLS and CSV formats##

sleep 2
 
$Sheet.SaveAs($xlsfile,$xlXLS)

$Excel.DisplayAlerts = 'False'
$Excel.Quit()

Disconnect-VIServer -Server 172.22.242.26 -Confirm:$false


######################################################################################################################
######################################################################################################################
##Email Report as attachment##

$From = "Saha, Sayan < sayan.saha@in.unisys.com>"
#$To = "*Technology InTC-TIS-Windvirt <TechnologyInTC-TIS-Windvirt@unisys.com>"
$To = "Saha, Sayan < sayan.saha@in.unisys.com>"
$Cc = "Saha, Sayan < sayan.saha@in.unisys.com>"
$Date = ( get-date ).ToString('yyyy/MM/dd')
$Subject = "GTCI VMs Compliance Report - $Date"
$Attachment = $xlsfile
$SMTPServer = "NA-MAILRELAY-T3.na.uis.unisys.com"
$SMTPPort = "587"
$Body = "Hi Team, `n
Find SEP and SCCM status for the VMs in GTCI-Virtual cluster. `n
Note: The list contains all GTCI-Virtual Cluster VMs irrespective of OS and Power State. Please filter the list accordingly to find Windows Powered On VMs and take necessary action on the Non-Compliant VMs. `n

Thanks and Regards,

Sayan Saha
Microsoft® Certified IT Professional | ITIL V3 Foundation | System Analyst | TIS-InTC 
Unisys Global Services - India | Purva Premier No.135/1, Residency Road | Bangalore 560025 | Direct Phone: +91 080 41595943 | Net Phone: 7595943 | Mobile phone: +91 9663884091 | Email: sayan.saha@in.unisys.com
 

THIS COMMUNICATION MAY CONTAIN CONFIDENTIAL AND/OR OTHERWISE PROPRIETARY MATERIAL and is for use only by the intended recipient. If you received this in error, please contact the sender and delete the e-mail and its attachments from all devices.

"

Send-MailMessage -From $From -To $To -Cc $Cc -Subject $Subject -Body $Body -SmtpServer NA-MAILRELAY-T3.na.uis.unisys.com -Attachments $Attachment

########################################################################################################################
###End of Script
########################################################################################################################
