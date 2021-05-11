$File = Import-Csv -Path "c:\scripts\sample.csv"

foreach($row in $File)
{

   #Switch ($_.GroupName)
   # {
   #           Select the respective files to be installed here
   # }
   
   .\PsExec.exe $_.computername -u "gtci-dev\administrator" -p "Welcome@1" -h powershell.exe "\\gtci-vmarchive\SEP\test1.bat" -force  
   
}    