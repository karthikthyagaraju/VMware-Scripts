$File = Import-csv -Path "C:\scripts\expiredvms1.csv"

foreach($row in $File)
{
    Get-VM -Name $row.Name | select Name, PowerState 

}