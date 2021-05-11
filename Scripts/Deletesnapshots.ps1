$vmlist = Get-Content C:\Users\tkarthi1\Desktop\vmlist4.txt

foreach($VM in $VMlist) {
    Get-Snapshot -VM $vm | Remove-Snapshot -confirm:$false
}