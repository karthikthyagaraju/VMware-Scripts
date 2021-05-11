#Days older than
$HowOld = -3

#Path to the root folder
$Path = "E:\RV-Tools-Report\inblr-nvm-vcntr.eu.uis.unisys.com"

#Deletion files task
get-childitem $Path -recurse | where {$_.lastwritetime -lt (get-date).adddays($HowOld) -and -not $_.psiscontainer} |% {remove-item $_.fullname -force -verbose}

#Deletion empty folders task
do {
  $dirs = gci $Path -directory -recurse | Where { (gci $_.fullName -Force).count -eq 0 } | select -expandproperty FullName
  $dirs | Foreach-Object { Remove-Item $_ }
} while ($dirs.count -gt 0)