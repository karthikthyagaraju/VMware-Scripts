$esxs = Get-Cluster "ePortal-Cluster" | Get-VMHost

$vms = Get-VMhost $esxs | Get-VM | Where-Object{$_.powerstate -eq 'PoweredOn'}

foreach($vm in $vms)
    {
       
   # echo $vm

     $vm | Stop-VMGuest -confirm:$false
        
    }

    foreach($esx in $esxs)
    {
    
   # Set-VMHost -VMHost $esx -State Maintenance -Confirm:$false
    Stop-VMHost -VMHost $esx -Confirm:$false
    
    }
