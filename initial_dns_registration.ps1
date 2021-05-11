$adapters = Get-WmiObject Win32_NetworkAdapterConfiguration -Filter "IPEnabled = 'True'"
$adapters.SetDynamicDNSRegistration($true,$true)
ipconfig /flushdns
ipconfig /registerdns
Start-Sleep -Seconds 300
$adapters.SetDynamicDNSRegistration($true,$false)
ipconfig /flushdns
ipconfig /registerdns