$esxs = Get-VMHost

foreach($esx in $esxs)
{

 Get-vm -Location $esx | Where-Object{$_.PowerState -eq "PoweredOn"} | Select Name, PowerState | export-csv c:\temp\$esx.csv
 
}
