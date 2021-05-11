$cred = Get-Credential

Add-PSSnapin VMware.VimAutomation.Core
connect-viserver -server 172.22.242.26 -Credential $cred
 
 #New-CustomAttribute -Name "Tenant" -TargetType VMHost, VirtualMachine
 
 $file= import-csv -Path C:\Scripts\Owner.csv

foreach($row in $file)

{
    echo $row
    $vm = Get-VM $row.ClientFqn
    $vm | Set-Annotation -CustomAttribute "Owner" -Value $row.UserName
    $vm | Set-Annotation -CustomAttribute "Email Address" -Value $row.emailaddress
    #Get-VM $row.ClientFqn | Set-Annotation -CustomAttribute "Tenant" -Value $row.Tenant
    #Get-VM $row.ClientFqn | Set-Annotation -CustomAttribute "Manager" -Value $row.Managers

 }
