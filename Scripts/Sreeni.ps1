
Import-CSV "C:\Scripts\ESX07VMs - new.csv" | % { 

Move-VM -VM (Get-vm -Name $_.Name) -Destination (Get-VMHost "ESX09.gtci-dev.com")

}