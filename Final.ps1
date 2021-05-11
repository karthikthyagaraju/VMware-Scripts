Import-Module Posh-SSH
$ssh = $null
$username = "root"
$password = "U*spc2341"
$secstr = New-Object -TypeName System.Security.SecureString
$password.ToCharArray() | ForEach-Object {$secstr.AppendChar($_)}
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $secstr

$ssh = New-SSHSession -ComputerName 172.22.243.200  -Credential $cred -acceptkey  -Verbose -ConnectionTimeout 60 -ErrorAction Stop

if($?)
{
echo " Connected to India UCSD Instance" 
}
else
{
Write-host " Couldn't connect" -ErrorAction Stop
}

Invoke-SSHCommand -SSHSession $ssh -Command "/root/scripts/lease.sh"

Invoke-SSHCommand -SSHSession $ssh -Command "/root/scripts/vm_decommission.sh"

if($?)
{ Write-Host "VMs deleted successfully" }


Remove-SSHSession -SSHSession $ssh 

Remove-Item -Path 'C:\Scripts\India\expiredvms_old.csv' -Force
Rename-Item -Path 'C:\Scripts\India\expiredvms.csv' -NewName 'C:\Scripts\India\expiredvms_old.csv'

Get-SCPFile -ComputerName 172.22.243.200 -OperationTimeout 60 -ConnectionTimeout 60 -Credential $cred -RemoteFile "/root/scripts/expiredvms.csv" -LocalFile 'C:\Scripts\India\expiredvms.csv' -AcceptKey 

if($?)
{
echo "File Copied to PS Server"
}


Import-Module vmware.vimautomation.core

Connect-VIServer inblr-vcenter1.eu.uis.unisys.com -user "eu\inblr-erlbkp" -Password "7ZBL248Rwqch"

if($?)
{
echo "Successfully Connected to vCenter Server"
}


$file = import-csv -Path "C:\Scripts\India\expiredvms.csv"


$date = (get-date).ToString("dd-MM-yyyy")


#------------------------------------------------------------------#

$cls = Get-ResourcePool -name Expired*

#$file = import-csv -Path "C:\Scripts\India\expiredvms.csv"
$existingvms = @()
$existingvms = get-vm -Location $cls | Select Name
$expiredvms =@()
$renewedvms =@()
foreach($row in $file)
{

$expiredvms += $row.INSTANCEID

}


$renewedvms = $existingvms.Name  | where { $expiredvms -notcontains $_}

$newvms = $expiredvms | where {$existingvms.Name -notcontains $_}

#$currentvms = 

echo " Renewed VMs are" $renewedvms

echo " Existing VMs are" $existingvms

echo " New VMs which are lease expired are" $newvms 



#-------------------------------------------------------------------------#



$vmname = $args[0]
$obj = @()

#echo "I have reached here" >> C:\Scripts\move2.log
#echo "VM Name is $vmname" >> C:\Scripts\move2.log
foreach($row in $file)
{

if ($row.INSTANCEID -in $newvms)

{

$vmname = $row.INSTANCEID

$vm = Get-VM $vmname  
#| Select Name >> c:\scripts\move2.log
$cluster = Get-Cluster -VM $vm
$rp = Get-ResourcePool -VM $vm

$erp = $cluster | Get-ResourcePool -Name Expired*



echo " Move $vmname in $cluster from source resourcepool  $rp into destination resourcepool $erp"

Move-VM -VM $vm -Destination $erp -Confirm:$false
 


     $properties = @{
        'Date'  = $date
        'VMName' = $vm
        'Cluster' = $cluster
        'SourceRP' = $rp
        'SourceRPID' = $rp.Id
        'DestinationRP' = $erp
        'ExpiryDate' = $row.STT.SubString(0,10)
        
      }
    
    $obj += New-Object PSObject -Property $properties
    



}
}
$obj | Select Date, VMName, Cluster, SourceRP, SourceRPID, DestinationRP, ExpiryDate | Export-Csv -Path "c:\Scripts\India\ExpiredVMs_$date.csv" -NoTypeInformation



$obj | Select Date, VMName, Cluster, SourceRP, SourceRPID, DestinationRP, ExpiryDate | Export-Csv -Path "c:\Scripts\India\persist.csv" -NoTypeInformation -Append

#######################################################################################################################################################




#echo $renewedvms


<#foreach($value in $renewedvms)
{

echo $value

}
#>

if ($renewedvms)
{
 echo "Renewed vms is not null"

 $file1 = import-csv c:\Scripts\India\persist.csv


 foreach($value in $renewedvms)

 {
 
 foreach($row1 in $file1)
 {
 
    if ($value -eq $row1.VMName)
    {
    
    #echo $row

    $vm = $row1.VMName
    $DRP = $row1.DestinationRP
    $SRP = $row1.SourceRP
    $RPID = $row1.SourceRPID


    echo " Move "$row1.VMName" in "$row1.DestinationRP" to original resource pool "$row1.SourceRP"  with "$row1.SourceRPID" in "$row1.Cluster""
    Move-VM -VM $vm -Destination (Get-ResourcePool -id $row1.SourceRPID)
    break
    
    }

 }
 
 
 }



} 



$sender = "Verdia, Vijay <vijay.verdia@in.unisys.com>"
$email = @("*Technology InTC-TIS-Windvirt <TechnologyInTC-TIS-Windvirt@unisys.com>","TechnologyInTC-TIS-Backup@unisys.com")

$htmlout="c:\Scripts\India\expiredvmsstatus.html"
$date = (get-date).ToString("dd-MM-yyyy")


$title = "VM Archival Details"
$style = @"
<style>
TABLE{border-width: 3px;border-style: solid;border-color: black;border-collapse: collapse;}
TH{border-width: 2px;text-align: left;padding: 10px;border-style: solid;border-color: black;font-family: Arial;color: #FFFFFF;background-color:#08088A}
TD{border-width: 2px;text-align: left;padding: 10px;border-style: solid;border-color: black;font-family: Arial;color: #0A0A2A;background-color: #FAFAFA}
tr.special {background: #000080;} <tr class="special"></tr></style>
"@
$rpthead = @"
<font size="6"><b>
</b></font>
"@

$pre = @"
<p><i>Hi Team <br><br>PFB the list of $vmcount VMs which are lease expired and archived today.

"@

$last = @"
<p><i><br>Thanks & regards <br>Backup Team </i></p>
"@

$data = Get-Content "c:\Scripts\India\ExpiredVMs_$date.csv"
$vmcount = $data.count - 1

if($data)
{

Get-Content "c:\Scripts\India\ExpiredVMs_$date.csv"  | ConvertFrom-Csv | ConvertTo-Html -title $title -head $style -body $rpthead -PreContent $pre -PostContent $last| Out-File $htmlout
$BodyReport = Get-Content "c:\Scripts\India\expiredvmsstatus.html" -Raw
Send-MailMessage -SmtpServer na-mailrelay-t3.na.uis.unisys.com -To $email  -From $sender -cc "zahid.ashraf@in.unisys.com" -Subject "India : VM Archival Details " -BodyAsHtml "$BodyReport" -Attachments "c:\Scripts\India\ExpiredVMs_$date.csv"
#Get-ChildItem -Path C:\Backup -Include t*.* -Recurse | foreach { $_.Delete()}
#schtasks /run /s inblr-ddbackup.eu.uis.unisys.com /tn "TriggerArchiveBackups"

}
else
{

Send-MailMessage -SmtpServer na-mailrelay-t3.na.uis.unisys.com -To $email  -From $sender -cc "zahid.ashraf@in.unisys.com" -Subject "India : No VM has expired Yesterday." 



}


Disconnect-viserver inblr-vcenter1.eu.uis.unisys.com -confirm:$false
