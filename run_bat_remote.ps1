# This file contains the list of servers you want to copy files/folders to
$computers = Get-Content "C:\Users\tkarthi1\Desktop\vmy.txt"

$batfilename = "sccm.bat"
foreach ($computer in $computers) {
if ((Test-Connection -ComputerName $computer)) {
Invoke-Command -Computername $computer -ScriptBlock {param($batfilename) & cmd.exe /c "C:\temp\$batfilename" } -ArgumentList $batfilename -AsJob -ErrorAction SilentlyContinue
} else {
"$computer is not reachable or does not exist"
}
}
