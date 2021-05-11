﻿# This file contains the list of servers you want to copy files/folders to
$computers = Get-Content "C:\Users\tkarthi1\Desktop\vm - Copy.txt"

# This is the file/folder(s) you want to copy to the servers in the $computer variable
$source = "\\129.221.29.72\Share\SCCM\SCCM_5.0.8740.1810_u2.15.exe"

# The destination location you want the file/folder(s) to be copied to
$destination = "c$\Temp\"

foreach ($computer in $computers) {
if ((Test-Path -Path \\$computer\$destination)) {
Copy-Item $source -Destination \\$computer\$destination -Verbose
} else {
"\\$computer\$destination is not reachable or does not exist"
}
}