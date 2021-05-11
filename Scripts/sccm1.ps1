$File = Import-Csv "C:\Scripts\sccmhosts.csv"
foreach ($row in $File)
{ 
 #echo "Connecting to " $row.Name
 CMD /c  SC $row.Name start winrm
 #echo "Finished on " $row.Name
}