#New-CustomAttribute -Name "Tenant" -TargetType VMHost, VirtualMachine

schtasks /run /s inblr-gtcisql-v.eu.uis.unisys.com /tn "Attribute Task"

sleep 600

$path="C:\Scripts\Update_VM_Attributes"
cd $path
Get-ChildItem -Path $path -Include A*.* -Recurse | foreach { $_.Delete()}
Remove-item C:\Scripts\Update_VM_Attributes\FinalDataEngg_old.csv -Force -Confirm:$false
Rename-Item C:\Scripts\Update_VM_Attributes\FinalDataEngg.csv C:\Scripts\Update_VM_Attributes\FinalDataEngg_old.csv -Force -Confirm:$false
Copy-Item -Path '\\inblr-gtcisql-v.eu.uis.unisys.com\c$\Script\Vijay\FinalDataEngg.csv' -Destination $path\FinalDataEngg.csv
compare -ReferenceObject $(gc .\Finaldataengg_old.csv) -DifferenceObject $(gc .\Finaldataengg.csv) |  where-object{$_.SideIndicator -eq "=>"} | Select-Object InputObject | out-file AAA.csv -NoClobber -width 150

gc .\AAA.csv | Select-Object -Skip 3 | out-file AAAA.csv -Width 150 -Force

Import-Csv .\AAAA.csv -Header "ClientFQN","OwnerToken","OwnerName","EmailAddress","Tenant" | export-csv AAAAA.csv -NoTypeInformation -Force
$file= import-csv -Path C:\Scripts\Update_VM_Attributes\AAAAA.csv

Connect-VIServer -Server 172.22.242.26 -user gtci-dev\gtcirunbook -Password "Welcome1"

foreach($row in $file)
   
 {  
    #echo $row
    $vm = Get-VM $row.ClientFQN
    $vm | Set-Annotation -CustomAttribute "Owner" -Value $row.OwnerName
    $vm | Set-Annotation -CustomAttribute "Email Address" -Value $row.EmailAddress
    $vm | Set-Annotation -CustomAttribute "Tenant" -Value $row.Tenant
  }

  

  Disconnect-VIServer -Server 172.22.242.26 -confirm:$false