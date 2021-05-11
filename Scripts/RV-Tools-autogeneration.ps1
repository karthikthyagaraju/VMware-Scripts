<# 
.SYNOPSIS 
   Performs full export from RVTools
.DESCRIPTION
   Performs full export from RVTools. Archives old versions.
.NOTES 
   File Name  : RVToolsExport.ps1 
   Author     : Karthik
   Version    : 1
.PARAMETER Servers
   inblr-vcenter1.eu.uis.unisys.com
   172.22.242.200
.PARAMETER BasePath
   E:\RV-Tools-Report
.PARAMETER OldFileDays
   3 days
#>

param
(
   $Servers = @("inblr-vcenter1.eu.uis.unisys.com"),
   $BasePath = "K:\RV-Tools-Report"
   #$OldFileDays = 3
)

$Date = (Get-Date -f "yyyyMMdd")

foreach ($Server in $Servers)
{
   # Create Directory
   New-Item -Path "$BasePath\$Server\$Date" -ItemType Directory -ErrorAction SilentlyContinue | Out-Null 

   # Run Export
   . "C:\Program Files (x86)\Robware\RVTools\RVTools.exe" -s $Server -c ExportAll2csv -d "$BasePath\$Server\$Date"

   # Cleanup old files
   #$Items = Get-ChildItem -Directory "$BasePath\$server"
   #foreach ($item in $items)
   #{
      #$itemDate = ("{0}/{1}/{2}" -f $item.name.Substring(6,2),$item.name.Substring(4,2),$item.name.Substring(0,4))
      
      #if ((((Get-Date).AddDays(-$OldFileDays))-(Get-Date($itemDate))).Days -gt 0)
      #{
         #$item | Remove-Item -Recurse
      #}
   #}
}