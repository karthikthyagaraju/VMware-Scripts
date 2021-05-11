$file= import-csv -Path C:\Users\verdiavi\Desktop\vmpending.csv

New-VIProperty -Name ToolsVersion -ObjectType VirtualMachine -ValueFromExtensionProperty 'Config.tools.ToolsVersion' -Force

New-VIProperty -Name ToolsVersionStatus -ObjectType VirtualMachine -ValueFromExtensionProperty 'Guest.ToolsVersionStatus'  -Force


foreach($row in $file)
{
get-vm -Name $row.vmname | Select Name, Version, ToolsVersion, ToolsVersionStatus 

}


  