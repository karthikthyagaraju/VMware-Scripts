$a = 1

do{
    (New-Object -Com Shell.Application).Open("http://www.microsoft.com/")
    Start-Sleep -Seconds 10
    get-process chrome | stop-process
    start-sleep -Seconds 50

    $a++
}

while ($a -le 99999999)