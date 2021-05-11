Add-PSSnapin vmware.vimautomation.core

connect-viserver -server gtci-vcms.gtci-dev.com

$File = Import-Csv 'C:\scripts\8th march.csv'

Foreach ($row in $File)
{
    echo $row.name
    Export-VApp -VM $row.Name -Destination "H:\VMArchive"
}