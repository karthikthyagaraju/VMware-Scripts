Connect-VIServer 172.22.242.26 
#-User eu\inblr-script -Password 6VAs94Kw9gXy

$esxs = @("esx05.eu.uis.unisys.com","inblr-appcloud1.eu.uis.unisys.com","esx-ntx-apd1.eu.uis.unisys.com","esx-ntx-eng1.eu.uis.unisys.com")


ForEach($esx in $esxs)
{

echo $esx

$DSG1 = Get-datacenter GTCI-VIRTUAL | Get-vmhost "$esx" | Get-Datastore -Name VNX*, NTX-* | Sort FreeSpaceGB 

foreach ($row in $DSG1)
    {
    
    if($row.FreeSpaceGB -le (.1*$row.CapacityGB))

        {
        echo "$row is less than 10%"
       
            $vm = $row | Get-VM | Sort ProvisionedSpaceGB | Select -First 1
            #echo $vm
            $DSG2 = Get-datacenter GTCI-VIRTUAL | Get-vmhost "$esx" | Get-Datastore -Name VNX* | Sort FreeSpaceGB -Descending

            foreach($row1 in $DSG2)

            { 
              if($row1.FreeSpaceGB -ge (.15*$row1.CapacityGB))

              {
               #echo "$row1 is free and will receive $vm"
               $Task =  move-vm -VM $vm[0] -Datastore $row1 -Confirm:$false
                if(-not $?)
                {
                #$vm1 = $row | Get-vm | ?{ ($_.VMHost -notmatch "esx23.gtci-dev.com") -and ($_.PowerState -eq "PoweredOff")}|  Sort ProvisionedSpaceGB | Select -skip 2 |Select -First 1
                move-vm -VM $vm[1] -Datastore $row1 -Confirm:$false
                
                }

                break

              }
            }
        }
       
    }



}

Disconnect-VIServer -Server 172.22.242.26 -Confirm:$false