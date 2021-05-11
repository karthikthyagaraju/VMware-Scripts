$Templates = Get-Template -Location "ESX07.gtci-dev.com" | Where-Object{$_.Name -like "T-*"}

foreach($Template in $Templates)
{
    #echo $Template
    Set-Template -Template $Template -ToVM | Move-VM -Destination (Get-VMHost "ESX08.gtci-dev.com")|Set-VM -ToTemplate -confirm:$false
}