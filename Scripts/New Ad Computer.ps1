#Import-Module ActiveDirectory

$cred = Get-Credential  
$CSV="C:\Users\tkarthi1\Desktop\VM.csv"
$OU='OU=Servers,OU=GTCI,OU=Bangalore,OU=India,DC=eu,DC=uis,DC=unisys,DC=com'
Import-Csv -Path $CSV | ForEach-Object { New-ADComputer -Name $_.ComputerAccount -Path $OU -Enabled $False -Credential $cred}