Add-PSSnapin vmware.vimautomation.core
$vcenter = Read-Host "Enter vCenter Server IP/FQDN:" 
Connect-VIServer $vcenter

Write-host "`n
`n
Please wait....  Fetching data from vCenter"

$objReport = @()  
  
function Get-CDP    {  
    $obj = @()  
    Get-VMHost  | Where-Object {$_.State -eq "Connected"} | %{Get-View $_.ID} |  
    %{$esxname = $_.Name; Get-View $_.ConfigManager.NetworkSystem} |  
    %{ foreach($physnic in $_.NetworkInfo.Pnic){  
      
        $obj = "" | Select-Object hostname,pNic,pMAC,PortId,SwitchId,Address,vlan          
      
        $pnicInfo = $_.QueryNetworkHint($physnic.Device)  
        foreach($hint in $pnicInfo){  
          #Write-Host "$esxname $($physnic.Device)"  
          $obj.hostname = $esxname  
          $obj.pNic = $physnic.Device
          $obj.pMAC = $physnic.Mac 
          if( $hint.ConnectedSwitchPort ) {  
            # $hint.ConnectedSwitchPort  
            $obj.PortId = $hint.ConnectedSwitchPort.PortId 
            $obj.SwitchId =  $hint.ConnectedSwitchPort.DevId
          } else {  
            # Write-Host "No CDP information available."; Write-Host  
            $obj.PortId = "No CDP information available."  
          }  
          $obj.Address = $hint.ConnectedSwitchPort.Address  
          $obj.vlan = $hint.ConnectedSwitchPort.vlan  
            
        }  
        $objReport += $obj  
      }  
    }  
$objReport  
}  
  
$results = get-cdp
$results |  Export-Csv "c:\temp\CDP.csv"  -Force
Write-Host "`n
`n
File c:\temp\CDP.csv has been saved."

Start-Sleep 10