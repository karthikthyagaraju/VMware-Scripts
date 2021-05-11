$dt = Get-Date -Format "dd-MM-yyyy_HH_mm" 

$ScriptFullPath = "C:\Scripts\India\$dt"

# Start logging stdout and stderr to file
Start-Transcript -Path "$ScriptFullPath.log" -Append

C:\Scripts\India\Final.ps1

# Stop logging
Stop-Transcript