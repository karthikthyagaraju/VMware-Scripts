$cred = Get-Credential
Import-CSV "C:\Users\tsuthi\Desktop\VM.csv" | % { 
$Computer = $_.ComputerName 
$userd = $_.UserName 

$User = @()
$domains = "ap.uis.unisys.com","eu.uis.unisys.com","na.uis.unisys.com"

foreach($domain in $domains)
{
  $User += 	Get-ADUser -Filter 'DisplayName -eq $userd' -Server $domain  | Select-Object -First 1
}
$User1 = $User | Select-Object -First 1
echo $User1
Get-ADComputer $Computer -Server EU | Set-ADComputer -ManagedBy $User1 -Credential $cred
}