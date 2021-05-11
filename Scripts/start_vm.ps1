

$file = Import-Csv -Path C:\vm\vms.csv

foreach($row in $file)
{

Get-vm $row.name | Start-VM 

}