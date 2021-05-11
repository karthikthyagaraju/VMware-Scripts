$Secure = Read-Host -AsSecureString

$Encrypted = ConvertFrom-SecureString -SecureString $Secure

$Encrypted | Set-Content Encrypted.txt

$Secure2 = Get-Content Encrypted.txt | ConvertTo-SecureString