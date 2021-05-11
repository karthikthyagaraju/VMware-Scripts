 $file= import-csv -Path C:\Users\galok0\Desktop\filea.csv

foreach($row in $file)

{
    #echo $row
    Get-NetworkAdapter -VM $row.vmname | Set-NetworkAdapter -Connected:$false -WakeOnLan:$false -Confirm:$false

 }