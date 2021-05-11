

Import-Module vmware.vimautomation.core

Connect-VIServer -Server inblr-lab-vc.eu.uis.unisys.com -User na\uu-teammaster -Password Welcome@2

for($i=1;$i -lt 9; $i++)
{
$VMs = Get-ResourcePool -name "Team$i" | Get-VM


foreach($VM in $VMs)
{
  # echo $VM 
  $snap = Get-Snapshot -VM $VM |Where-Object{$_.Name -eq "Start Class"} -ErrorAction SilentlyContinue
  #echo $snap 
  Set-VM -VM $VM -SnapShot $snap -Confirm:$false -ErrorAction SilentlyContinue
  #Write-Host "Snapshot" $snap "is deleted for " $VM
}
}

Disconnect-VIServer -Confirm:$false


##################################################################
$PW = New-Object object[] 11
$ascii1=$NULL;
$ascii2=$NULL;
$ascii3=$NULL;
$ascii4=$NULL;
$ascii5=$NULL;
For ($a=33;$a –le 39;$a++) 
{$ascii2+=,[char][byte]$a }
For ($a=48;$a –le 58;$a++) 
{$ascii3+=,[char][byte]$a }
For ($a=65;$a –le 91;$a++) 
{$ascii4+=,[char][byte]$a }
For ($a=97;$a –le 123;$a++) 
{$ascii1+=,[char][byte]$a }
$ascii5 = $ascii1 + $ascii4     
 Function GET-Temppassword() {

Param(

[int]$length=8

)

 

For ($loop=1; $loop –le $length; $loop++) {

            
            switch ($loop)
            {
            
            1 {$TempPassword+= Get-Random -InputObject $ascii2}
            2 {$TempPassword+= Get-Random -InputObject $ascii3}
            3 {$TempPassword+= Get-Random -InputObject $ascii4}
            4 {$TempPassword+= Get-Random -InputObject $ascii1}
            default {$TempPassword+= Get-Random -InputObject $ascii5}
            
            }
            }

         return $TempPassword

}
#########################################################################

$username = "na\uu-teammaster"
$password = Get-Content C:\scripts\Encrypted.txt | ConvertTo-SecureString
$cred = new-object -typename System.Management.Automation.PSCredential -ArgumentList $username, $password



for($i=1;$i -lt 9; $i++)
{
  
  $pass = GET-Temppassword –length 8   
  $PW[$i] = $pass
  
  $pass1 = ConvertTo-SecureString -String $pass -AsPlainText -Force

  Get-ADUser UU-Team$i -Properties LockedOut -server na.uis.unisys.com | Where-Object {$_.LockedOut -eq $True} | Unlock-ADAccount  -Server na.uis.unisys.com -Credential $cred
  
  Set-ADAccountPassword "CN=UU-Team$i,OU=Service Accounts,OU=Resources,OU=Tredyffrin,OU=United States,DC=na,DC=uis,DC=unisys,DC=com" -Reset -NewPassword $pass1  -server na.uis.unisys.com -Credential $cred
    
  <#if($?)
  {
  echo "Team$i password reset successfully "
  }
  else
  {

  echo "Team$i password didn't reset, trying again"
  $error[0]
  $pass = GET-Temppassword –length 8 –sourcedata $ascii   
  $PW[$i] = $pass
  $pass1 = ConvertTo-SecureString -String $pass -AsPlainText -Force
  Set-ADAccountPassword "CN=UU-Team$i,OU=Service Accounts,OU=Resources,OU=Tredyffrin,OU=United States,DC=na,DC=uis,DC=unisys,DC=com" -Reset -NewPassword $pass1  -server na.uis.unisys.com -Credential $cred
   
  } #> 

}

##########################################################################

#$body = $PW.ToString
#echo $body
$body = $PW | Out-String 



Send-MailMessage  -from "Stealth Lab <StealthLab@unisys.com>"    -to "UnisysStealthTrainings@unisys.com"    -Subject "Lab Credentials"  -Body $body    -Cc "Vijay <vijay.verdia@unisys.com>","karthik.t2@in.unisys.com"    -SmtpServer na-mailrelay-t3.na.uis.unisys.com  
 