$credential = Get-Credential
$credential.Password | ConvertFrom-SecureString | Set-Content c:\scripts\Sayan_encryptedpassword.txt