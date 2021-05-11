$results = @()
$objects = Get-Content -Path "C:\Users\tkarthi1\Desktop\Crown Jewels\User_list.txt"
$domains = "ap.uis.unisys.com","eu.uis.unisys.com","na.uis.unisys.com"
ForEach($object in $objects){
foreach($domain in $domains)   

    {
     $results += Get-Aduser -Identity "$objects" -Server $domain | Select-Object -Property samaccountname,disabled
    }
   }
$results | Export-Csv "C:\Users\tkarthi1\Desktop\Crown Jewels\Disabled-Users.csv" 