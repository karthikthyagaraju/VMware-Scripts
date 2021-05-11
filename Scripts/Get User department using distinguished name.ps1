$results = @()
$objects = Get-Content "C:\Users\tkarthi1\Desktop\User.csv"
$domains = "ap.uis.unisys.com","eu.uis.unisys.com","na.uis.unisys.com"
ForEach($object in $objects){
foreach($domain in $domains)   

    {
     #$email = "karthik.t2@in.unisyscom"
     #$domain = "ap.uis.unisys.com"
     $results += Get-ADObject -Filter {DistinguishedName -eq $object} -Server $domain -Property cn, SamAccountName, UserPrincipalName, Department | Select-Object  Department, UserPrincipalName, cn,  @{N='Domain\username';E={ "$((($_.DistinguishedName -split 'DC=')[1]).Replace(',',''))\$($_.SamAccountName)"}}
    }
   }
$results | export-csv "C:\Users\tkarthi1\Desktop\Wanted-info3.csv"