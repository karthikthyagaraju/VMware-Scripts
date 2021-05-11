#To Install Module during First run
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -Confirm:$false
Start-Sleep -Seconds 5
Set-PSRepository 'PSGallery' -InstallationPolicy Trusted
Install-Module PSWindowsUpdate -MinimumVersion 2.1.1.2 -Confirm:$false
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force -Confirm:$false
Import-Module 'PSWindowsUpdate'

#To Install Updates
#Install-WindowsUpdate -AcceptAll -ForceDownload -ForceInstall -AutoReboot -Confirm:$false