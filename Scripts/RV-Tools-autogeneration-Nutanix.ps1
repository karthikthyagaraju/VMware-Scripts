param
(
   $Servers = @("inblr-vcenter1.eu.uis.unisys.com"),
   $BasePath = "K:\RV-Tools-Report"
)

$Date = (Get-Date -f "yyyyMMdd")

foreach ($Server in $Servers)
{
   # Create Directory
   New-Item -Path "$BasePath\$Server\$Date" -ItemType Directory -ErrorAction SilentlyContinue | Out-Null 

   # Run Export
   . "C:\Program Files (x86)\Robware\RVTools\RVTools.exe" -u administrator@vsphere.local -p U*spc2341 -s $Server -c ExportAll2csv -d "$BasePath\$Server\$Date"
}