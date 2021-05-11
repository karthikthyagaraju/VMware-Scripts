# To run this script open Powershell ISE as an administrator and run the below command
# Add-PSSnapin Vmware.vimautomation.core
#Connect-VIServer -server gtci-vcms.gtci-dev.com
# The Import-CSV path should have the location of the input file from where we want to pull the name of VM's
# The Destination path should be the location where you want to save the OVF files.

$File = Import-Csv "C:\Users\galok0\Desktop\Vm's expired before 15thDec.csv"

Foreach ($row in $File)
{
    echo $VM
    Export-VApp -VM $row.Name -Destination "E:\Alok_DONT_DELETE-VM's Expired before 15thDec"


}