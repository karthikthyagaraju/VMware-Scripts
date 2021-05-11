Import-Module vmware.vimautomation.core

Connect-VIServer -Server inblr-lab-vc.eu.uis.unisys.com -User na\uu-teammaster -Password fG44Vj4N5Ggh

for($i=8;$i -lt 9; $i++)
{
$VMs = Get-ResourcePool -name "UU Team$i" | Get-VM


foreach($VM in $VMs)
{
  # echo $VM 
  $snap = Get-Snapshot -VM $VM |Where-Object{$_.Name -eq "Start Class"} -ErrorAction SilentlyContinue
  #echo $snap 
  Set-VM -VM $vm -SnapShot $snap -Confirm:$false -ErrorAction SilentlyContinue
}
}

Disconnect-VIServer -Confirm:$false


##################################################################

$PW = New-Object object[] 10
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

#########################################################################

$username = "na\uu-teammaster"
$password = cat C:\scripts\securestring.txt | convertto-securestring
$cred = new-object -typename System.Management.Automation.PSCredential -ArgumentList $username, $password



for($i=8;$i -lt 9; $i++)
{
  
  $pass = GET-Temppassword –length 8 –sourcedata $ascii   
  $PW[$i] = $pass
  
  $pass1 = ConvertTo-SecureString -String $pass -AsPlainText -Force

  Get-ADUser UU-Team$i -Properties * -server na.uis.unisys.com | Where-Object {$_.LockedOut -eq $True} | Unlock-ADAccount  -Server na.uis.unisys.com -Credential $cred
  
  Set-ADAccountPassword "CN=UU-Team$i,OU=Service Accounts,OU=Resources,OU=Tredyffrin,OU=United States,DC=na,DC=uis,DC=unisys,DC=com" -Reset -NewPassword $pass1  -server na.uis.unisys.com -Credential $cred

     

}

##########################################################################

#$body = $PW.ToString
#echo $body
$body = $PW[8] | Out-String 



Send-MailMessage  -from "Stealth Lab <StealthLab@unisys.com>"    -to "UnisysStealthTrainings@unisys.com"    -Subject "Lab Credentials"  -Body $body    -Cc "Vijay <vijay.verdia@unisys.com>"    -SmtpServer na-mailrelay-t3.na.uis.unisys.com  
 