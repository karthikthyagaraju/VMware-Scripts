$results = @()
$objects = Get-Content "C:\Users\tkarthi1\Desktop\User.csv"
$domains = "ap.uis.unisys.com","eu.uis.unisys.com","na.uis.unisys.com"
ForEach($object in $objects){
foreach($domain in $domains)   

    {
     $results += Get-Aduser -Filter {EmailAddress -like $object} -Server $domain -Property cn, SamAccountName, UserPrincipalName, Department | Select-Object  Department, UserPrincipalName, cn,  @{N='Domain\username';E={ "$((($_.DistinguishedName -split 'DC=')[1]).Replace(',',''))\$($_.SamAccountName)"}}
    }
   }
$results | export-csv "C:\Users\tkarthi1\Desktop\Wanted-info3.csv"