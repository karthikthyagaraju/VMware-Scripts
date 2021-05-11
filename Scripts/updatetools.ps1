$file= import-csv -Path C:\Users\verdiavi\Desktop\vmpending.csv

foreach($row in $file)
{
$vm = get-vm -Name $row.vmname
Update-Tools $vm -NoReboot

}