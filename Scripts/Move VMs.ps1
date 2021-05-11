$VMs= Get-VM -location "esx03.gtci-dev.com"

foreach($VM in $VMs)

{
  #echo $VM.Name
  #Move-VM -VM $VM -Destination (Get-Random "ESX04.gtci-dev.com", "ESX05.gtci-dev.com", "ESX06.gtci-dev.com", "ESX07.gtci-dev.com", "ESX08.gtci-dev.com", "ESX09.gtci-dev.com")
  Move-VM -VM $VM -Destination "ESX08.gtci-dev.com"
    }