#To Importing Module#
Set-ExecutionPolicy Bypass -Force -Confirm:$false
import-Module "C:\Users\tkarthi1\OneDrive - Unisys\Scripts\GroupMembers\GroupMembers.psm1"

#Fetch Users list from Systems#

Get-Content "C:\Users\tkarthi1\Desktop\Crown Jewels\Servers.txt" | foreach-object {
    $Comp = $_
Get-GroupMembers -ComputerName $Comp -RemoteGroups Administrators 
} | Export-Csv "C:\Users\tkarthi1\Desktop\Crown Jewels\User_AccessList.csv" -Verbose

#Remove users from Systems#
#Remove-GroupMember -ComputerName inblr-vmarchive.eu.uis.unisys.com -RemoteGroup "Administrators" -Domain NA -User sa_ugsi_GAlok0