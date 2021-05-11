#$cred = Get-Credential 
#-password fG44Vj4N5Ggh
#read-host -assecurestring | convertfrom-securestring | out-file C:\mysecurestring.txt

$username = "na\uu-teammaster"
$password = cat C:\mysecurestring.txt | convertto-securestring
$cred = new-object -typename System.Management.Automation.PSCredential `
         -argumentlist $username, $password

$ascii=$NULL;For ($a=33;$a –le 126;$a++) {$ascii+=,[char][byte]$a }
     


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

for($i=1; $i -lt 6; $i++)
{

$Pass = 
$PW= GET-Temppassword –length 8 –sourcedata $ascii 
echo $PW 


Set-ADAccountPassword 'CN=UU-Team10,OU=Service Accounts,OU=Resources,OU=Tredyffrin,OU=United States,DC=na,DC=uis,DC=unisys,DC=com' -Reset -NewPassword (ConvertTo-SecureString -AsPlainText $PW -Force) -server na.uis.unisys.com -Credential $cred














Send-MailMessage

#Unlock-ADAccount -Identity 'CN=UU-Team10,OU=Service Accounts,OU=Resources,OU=Tredyffrin,OU=United States,DC=na,DC=uis,DC=unisys,DC=com' -Server na.uis.unisys.com -Credential $cred

Import-Module vmware.vimautomation.core

Connect-VIServer -Server inblr-lab-vc.eu.uis.unisys.com -User na\uu-teammaster -Password fG44Vj4N5Ggh

$VMs = Get-vm -Name "EMServer-10" 

foreach($VM in $VMs)
{
  # echo $VM 
  $snap = Get-Snapshot -VM $VM |Where-Object{$_.Name -eq "Start Class"}
  #echo $snap 
  Set-VM -VM $vm -SnapShot $snap -Confirm:$false
}

