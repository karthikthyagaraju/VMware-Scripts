Connect-VIServer "inblr-vcenter1.eu.uis.unisys.com" -User eu\inblr-script -Password 6VAs94Kw9gXy
$drsGroup = Get-DrsClusterGroup -Name "RHEL-ENGG-VM"
$RHEL = Get-VM -Location "NTX-Engineering" | sort | where {$_.Guest -like "*Red Hat Enterprise Linux*"} | select name,@{N="Configured OS";E={$_.ExtensionData.Config.GuestFullname}}
foreach ($RHELs in $RHEL){

select name,@{N='DRSGroup';E={$script:group = Get-DrsClusterGroup -VM $_; $script:group.Name}}

if ($RHELs.DRSGroup -eq $null)
{
Write-Output "$RHELs is not added to Host Group"
Set-DrsClusterGroup -DrsClusterGroup $drsGroup -VM $RHELs.Name -Add
}
else
{
Write-Output "$RHELs is already added to Host Group"
}}
    
