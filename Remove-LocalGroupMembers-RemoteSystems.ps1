Get-Content "C:\Users\tkarthi1\Desktop\Crown Jewels\Servers.txt" | foreach-object {
    $Comp = $_
    #$ComputerName1 = "USRV-MSCS-2"
$adsi = [adsi]"WinNT://$Comp" 
$adminGroup = $adsi.Children.Find("Administrators", "Group")
foreach ($mem in $adminGroup.psbase.Invoke("members"))
 {
    $type = $mem.GetType()
    $name = $type.InvokeMember("Name", "GetProperty", $null, $mem, $null) # Not sure what this equals if there's no account
    [byte[]]$sidBytes = $type.InvokeMember("ObjectSid", "GetProperty", $null, $mem, $null)
    $sid = New-Object System.Security.Principal.SecurityIdentifier($sidBytes, 0)
    
    # Maybe try translating it?
    try
    {
        $ntAcct = $sid.Translate([System.Security.Principal.NTAccount])
    }
    catch [System.Management.Automation.MethodInvocationException]
    {
        # Couldn't translate, could be a candidate for removal
        Write-Warning "I would remove $($sid.Value)..."
         $adminGroup.Remove(("WinNT://$sid")) # Actual Removal
    }
 }
}