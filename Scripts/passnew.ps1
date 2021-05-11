$PW = (1..10)
$ascii=$NULL;
For ($a=33;$a –le 39;$a++) 
{$ascii+=,[char][byte]$a }
For ($a=48;$a –le 58;$a++) 
{$ascii+=,[char][byte]$a }
For ($a=65;$a –le 91;$a++) 
{$ascii+=,[char][byte]$a }
For ($a=97;$a –le 123;$a++) 
{$ascii+=,[char][byte]$a }

#echo $ascii
     
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

#########################################################################

$username = "na\uu-teammaster"
$password = cat C:\scripts\securestring.txt | convertto-securestring
$cred = new-object -typename System.Management.Automation.PSCredential -ArgumentList $username, $password



for($i=8;$i -lt 9; $i++)
{
  
  $PW[$i] = GET-Temppassword –length 8 –sourcedata $ascii   
  #$PW[8] = "(5GJlRhV"
  $pass = $PW[$i] | Out-String
  echo $pass

  


    Get-ADUser UU-Team$i -Properties * -server na.uis.unisys.com | Where-Object {$_.LockedOut -eq $True} | Unlock-ADAccount  -Server na.uis.unisys.com -Credential $cred
    
    Set-ADAccountPassword "CN=UU-Team$i,OU=Service Accounts,OU=Resources,OU=Tredyffrin,OU=United States,DC=na,DC=uis,DC=unisys,DC=com" -Reset -NewPassword (ConvertTo-SecureString -AsPlainText $pass -Force) -server na.uis.unisys.com -Credential $cred

     

}