Import-Module vmware.vimautomation.core
connect-viserver inblr-lab-vc.eu.uis.unisys.com -User administrator@vsphere.local -Password "Stealth@123"

$tasks = Get-task -Status Queued
foreach($task in $tasks)
{
Stop-Task -Task $task -Confirm:$false 
}  