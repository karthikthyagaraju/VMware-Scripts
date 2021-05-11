Import-Module vmware.vimautomation.core

Connect-VIServer -Server inblr-lab-vc.eu.uis.unisys.com -User na\uu-teammaster -Password fG44Vj4N5Ggh


Function Get-ViSession {
$SessionMgr = Get-View $DefaultViserver.ExtensionData.Client.ServiceContent.SessionManager
$AllSessions = @()
$SessionMgr.SessionList | Foreach {
$Session = New-Object -TypeName PSObject -Property @{
Key = $_.Key
UserName = $_.UserName
FullName = $_.FullName
LoginTime = ($_.LoginTime).ToLocalTime()
LastActiveTime = ($_.LastActiveTime).ToLocalTime()

}
If ($_.Key -eq $SessionMgr.CurrentSession.Key) {
$Session | Add-Member -MemberType NoteProperty -Name Status -Value “Current Session”
} Else {
$Session | Add-Member -MemberType NoteProperty -Name Status -Value “Idle”
}
$Session | Add-Member -MemberType NoteProperty -Name IdleMinutes -Value ([Math]::Round(((Get-Date) – ($_.LastActiveTime).ToLocalTime()).TotalMinutes))
$AllSessions += $Session
}
$AllSessions
}

Function Disconnect-ViSession {

[CmdletBinding()]
Param (
[Parameter(ValueFromPipeline=$true)]
$SessionList
)
Process {
$SessionMgr = Get-View $DefaultViserver.ExtensionData.Client.ServiceContent.SessionManager
$SessionList | Foreach {
Write “Disconnecting Session for $($_.Username) which has been active since $($_.LoginTime)”
$SessionMgr.TerminateSession($_.Key)
}
}
}

Get-ViSession | where {$_.UserName -like "NA\UU-Team10"  } | Disconnect-ViSession