#To Importing Module#
Set-ExecutionPolicy Bypass -Force -Confirm:$false
import-Module "C:\Users\tkarthi1\OneDrive - Unisys\Scripts\GroupMembers\GroupMembers.psm1"

#Fetch Users list from Systems#

Get-Content "C:\Users\tkarthi1\Desktop\Crown Jewels\RemoveUserFromServers.txt" | foreach-object {
    $Comp = $_ 
Get-Content "C:\Users\tkarthi1\Desktop\Crown Jewels\RemoveUsers.txt" | foreach-object  {
    $Users = $_
Remove-GroupMember -ComputerName $Comp -RemoteGroup "Administrators" -Domain EUUS_Chef_Run -User $Users -ErrorAction SilentlyContinue 
}
}