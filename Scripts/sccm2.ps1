$File = Import-Csv "C:\Scripts\oshosts.csv"
foreach ($row in $File)
{ 
 #echo "Connecting to " $row.Computer
 #.\PsExec.exe $row.computer -h -n 30 -accepteula  cmd.exe /C netsh advfirewall firewall set rule group="Windows Management Instrumentation (WMI)" new enable=yes
 .\PsExec.exe \\inblr-vm- -d -h -n 30 -accepteula   cmd.exe /C "\\inblr-vmarchive\share\test.bat"

 $computer = $row.Computer

 $OS = Get-WmiObject -Computer $computer -Class Win32_OperatingSystem -Credential $cred

 echo $row.Computer $OS.caption | Export-Csv -Path c:\temp\output.txt -Append -NoTypeInformation
 #echo "Finished on " $row.Computer
}