Connect-VIServer 172.22.242.26 -User gtci-dev.com\gtcirunbook -Password Welcome1


$esxs = @("esx05.gtci-dev.com","esx12.gtci-dev.com","esx18.gtci-dev.com","inblr-appcloud1.gtci-dev.com")

ForEach($esx in $esxs)
{

echo $esx

$DSG1 = Get-datacenter GTCI-VIRTUAL | Get-vmhost "$esx" | Get-Datastore -Name VNX_VMAX* | Sort FreeSpaceGB 
#echo $DSG1

foreach ($row in $DSG1)
    {
    
    if($row.FreeSpaceGB -le 200)

        {
        
            $vm = $row | Get-VM | Sort ProvisionedSpaceGB | Select -First 1
           # echo $vm
            $DSG2 = Get-datacenter GTCI-VIRTUAL | Get-vmhost "$esx" | Get-Datastore -Name VNX_VMAX* | Sort FreeSpaceGB -Descending

            foreach($row1 in $DSG2)

            { 
              if($row1.FreeSpaceGB -ge 300)

              {

                move-vm -VM $vm -Datastore $row1 -Confirm:$false
                break

              }
            }
        }
    
    
    
    
    }

}

Disconnect-VIServer -Server 172.22.242.26 -Confirm:$false