#Ping a list of host names and gives the output 


$names = Get-content C:\vm\ips.csv

foreach ($name in $names)
{
  if (Test-Connection -ComputerName $name -Count 4 -ErrorAction SilentlyContinue)
  
    {
        Write-Host "$name is up" -ForegroundColor Green
    }
   else
       {
        Write-Host "$name is down" -ForegroundColor Red
       }

}