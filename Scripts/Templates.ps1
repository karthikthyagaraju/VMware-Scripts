Add-PSSnapin vmware.vimautomation.core

connect-viserver -server gtci-vcms.gtci-dev.com

$File = Import-Csv 'C:\scripts\templates2.csv'

Foreach ($row in $File)
{
        $myvm = set-template -Template $row.name -tovm
        Export-VApp -VM $myvm -Destination "D:\VMArchive\Templates"
        set-vm -VM $myvm -Name $myvm -ToTemplate -Confirm:$false 
}