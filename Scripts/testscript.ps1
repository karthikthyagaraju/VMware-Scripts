$PW = New-Object object[] 11
$ascii=$NULL;
For ($a=33;$a –le 39;$a++) 
{$ascii+=,[char][byte]$a }
For ($a=48;$a –le 58;$a++) 
{$ascii+=,[char][byte]$a }
For ($a=65;$a –le 91;$a++) 
{$ascii+=,[char][byte]$a }
For ($a=97;$a –le 123;$a++) 
{$ascii+=,[char][byte]$a }
     
 Function GET-Temppassword() {

Param(

[int]$length=8,

[string[]]$sourcedata

)

 

For ($loop=1; $loop –le $length; $loop++) {

            $TempPassword+=($sourcedata | GET-RANDOM)

            }

return $TempPassword

}



  $pass = GET-Temppassword –length 8 –sourcedata $ascii   
  #$PW[$i] = $pass
  
  $pass1 = ConvertTo-SecureString -String $pass -AsPlainText -Force






$i = 2




$username = "na\uu-teammaster"
$password = Get-Content C:\scripts\Encrypted.txt | ConvertTo-SecureString
$cred = new-object -typename System.Management.Automation.PSCredential -ArgumentList $username, $password

$Identity = Get-ADUser UU-Team$i -Properties LockedOut -server na.uis.unisys.com | Where-Object {$_.LockedOut -eq $False}

Unlock-ADAccount -Identity $Identity  -Server na.uis.unisys.com -Credential $cred
  
 Set-ADAccountPassword "CN=UU-Team$i,OU=Service Accounts,OU=Resources,OU=Tredyffrin,OU=United States,DC=na,DC=uis,DC=unisys,DC=com" -Reset -NewPassword $pass1  -server na.uis.unisys.com -Credential $cred
 
 sleep   