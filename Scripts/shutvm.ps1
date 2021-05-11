#Connect-VIServer "172.22.242.26"

$esxs = get-cluster "Stealth Cluster" | Get-VMHost

$vms = Get-VMhost $esxs | Get-VM | Where-Object{$_.powerstate -eq 'PoweredOn'}

foreach($vm in $vms)
    {
       
       #echo $vm
        $vm | Stop-VMGuest -confirm:$false
        
    }


        foreach($esx in $esxs)
    {
    
   # Set-VMHost -VMHost $esx -State Maintenance -Confirm:$false
    Stop-VMHost -VMHost $esx -Confirm:$false
    
    }


#$file= import-csv -Path C:\Users\verdiavi\Desktop\vmlist.csv

#foreach($row in $file)
#{
# get-vm -Name $row.vmname | Stop-VM -confirm:$false
#
#}

