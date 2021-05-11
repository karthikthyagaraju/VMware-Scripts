function Get-GroupMembers {
<#
  .Synopsis
    Get the list of Members from local group or remote local group
  .Description
    The Get-GroupMembers command collects the list of members in the given group or Default Administrators Group. 
  .Example
    Get-LocalGroupMembers
    It will show members from Administrators Local group on localhost. And save FailedComputer.log file under c:\Temp.
  .Example
    "192.168.33.11" | Get-Groupmembers
    Cat c:\temp\Computerlist.txt | Get-Groupmembers
    GroupMembers is capable of taking output pipeline.
  .Example
    Get-GroupMembers Server001 -LogFiles D:\CheckManually.Log
    Collect list for single computer Server001 and keep the logs for failed computers on D:\CheckManually.log
  .Example
    Get-GroupMembers -ComputerName server001, Server002 -RemoteGroups Administrators, "Remote Desktop Users"
    It will collect the list of members from Administrators and Remote Desktop Users Local Group on Server001 and Server002

    ComputerName                  IPAddress                      Administrators Members Count Administrators Members 
    ------------                  ---------                      ---------------------------- ----------------------
    server001                     ::1, 169.254.80.126, 192.1...                             2 VCLOUD\Administrator...
    Server002                     192.168.33.16                                             2 CLIENT001\Administrator...
    
  .Example
    Get-AdComputers -Filter * | Get-GroupMembers 
    It will collect the list of members from Administrators and Remote Desktop Users Local Group on Server001 and Server002, failed computers list is saved in txt file on c:\temp\failedComputers.csv.
  .Example
    Get-GroupMembers -ComputerName server001, Server002 -RemoteGroups Administrators, "Remote Desktop Users" | Export-csv -Path c:\temp\CollectedData.csv
    It will collect the list of members from Administrators and Remote Desktop Users Local Group on Server001 and Server002, Collected reports are saved in CSV file on c:\temp\CollectedData.csv.
  .Example
   $cred = (Get-Crendential)
   "Server001", "Server002" | Get-Groupmembers -RemoteGroups "Power Users" -Credential $cred
   Servers can be passed from array or files, and you can specify crendetials
  .Parameter ComputerName
    It is Alias to Name parameter
    You can provide multiple computername names or single one, if kept blank by default will take Localhost.
  .Parameter RemoteGroups
    You can provide multiple remote group names or single one, if kept blank by default will take Administrators as default.
  .Inputs
    [string]
  .OutPuts
    Server connection establised sucessfully and collected data.
    ∞ AD001 is reachable attempting to connect...
                         √ Connection established to Server AD001, Collecting Information...
                         √ Information is collected successfully.

    Server cannbot be reachable by any means
    × VC001 is not pinging or not on the Network, May be due to Firewall, Trying to connect....
                         × Server VC001 cannot be contacted, skipped it
   
    Server is pinging but cannot make connection due to Access Denied or RPC unavailable or non-Windows OS.
    ∞ ESXI001 is reachable attempting to connect...
                         × Server ESXI001 is reachable but not able to connect, Please check manually
  .Notes
    NAME:  Get-GroupMembers
    AUTHOR: Kunal Udapi
    LASTEDIT: 2nd August 2015
    KEYWORDS: Local Groups, Remote Local Groups
  .Link
    #Check Online version: Http://kunaludapi.blogspot.com 
    #Requires -Version 4.0
 #>
[CmdletBinding(SupportsShouldProcess)]
Param(
    [Parameter(<#Mandatory=$true,#>Position=1,
        ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true)]#ComputerName Parameters
    [AllowNull()]
    [alias(<#"DNSHostName",#>"ComputerName")]
    [string[]]$Name = 'LocalHost', 

    [Parameter(<#Mandatory=$true,#> Position=2)]
    [AllowNull()]    
    [alias("RemoteGroupNames")]
    [string[]]$RemoteGroups = 'Administrators',

    #[Parameter(Mandatory=$true)]
    [System.Management.Automation.PSCredential]$Credential,
    [String]$Logfile = "C:\Temp\FailedComputers.log"
) #Param

begin {
    $Report = @()
    if (-not $(Test-Path -Path $Logfile)) {
        $oldFilename = "{0:yyyyMMddhhss}-{1}" -f (Get-Date), (Split-Path -Path $Logfile -Leaf)
        New-Item -Path $Logfile -Force -ItemType File | Out-Null
    }
    else {
        $filepath = Split-Path -Path $Logfile
        $oldFilename = "{0}\{1:yyyyMMddhhss}-{2}" -f $filepath, (Get-Date), (Split-Path -Path $Logfile -Leaf)
        Get-Item $Logfile | Rename-Item -NewName $oldFilename -Force
    }
#region Function
    function Validate-Server {
        Param(
        [Parameter(Mandatory=$true, Position=1,
            ParameterSetName="Server", 
            ValueFromPipeline=$true)]#ComputerName Parameters
        [string]$Server,
        [String]$log
        ) #Param
        if (Test-Connection $Server -Count 2 -Quiet) {
            Write-Host "$([char]8734) $Server is reachable attempting to connect..." -ForegroundColor Yellow
            Try {
                if ($Credential -eq $null) {
                    $GroupInfo = Get-WmiObject Win32_GroupUser -ComputerName $Server -ErrorAction SilentlyContinue
                } #($Credential -eq $null)
                else {
                    $GroupInfo = Get-WmiObject Win32_GroupUser -ComputerName $Server -Credential $Credential -ErrorAction SilentlyContinue
                } #($Credential -eq $null)
            } #try Groupinfo
            Catch {
                Write-Host "`t `t `t $([char]215) Server $Server reachable but not able to connect, Please check manually" -ForegroundColor Red
                $GroupInfoTest =  "IsEmpty"
                $Server | Out-File -FilePath $log -Append
                Continue
            }
                if ($GroupInfo -eq $null -and $GroupInfoTest -eq $null ) {
                    Write-Host "`t `t `t $([char]215) Server $Server is reachable but not able to connect, Please check manually" -ForegroundColor Red
                    Continue
                } #if GroupInfo = $null
                elseif ($GroupInfoTest -eq "IsEmpty") {
                    $GroupInfoTest = $null
                }
                else {
                    Write-Host "`t `t `t $([char]8730) Connection established to Server $Server, Collecting Information..." -ForegroundColor Green 
                    $GroupInfo
                    Write-Host "`t `t `t $([char]8730) Information is collected successfully." -ForegroundColor Green
                }#Else GroupInfo = $null
         } #if Test-Connection $Server -Count 2 -Quiet
        else {
            Write-Host "$([char]215) $Server is not pinging or not on the Network, May be due to Firewall, Trying to connect...." -backgroundColor DarkRed
            Try {
                if ($Credential -eq $null) {
                    $GroupInfo = Get-WmiObject Win32_GroupUser -ComputerName $Server -ErrorAction SilentlyContinue
                } #($Credential -eq $null)
                else {
                    $GroupInfo = Get-WmiObject Win32_GroupUser -ComputerName $Server -Credential $Credential -ErrorAction SilentlyContinue
                } #($Credential -eq $null)
            } #try Groupinfo
            Catch {
                Write-Host "`t `t `t $([char]215) $Server reachable but not able to connect, Please check manually" -ForegroundColor Red
                $GroupInfoTest =  "IsEmpty"
            } #try Groupinfo
            if ($GroupInfo -eq $null -and $GroupInfoTest -eq $null ) {
                    Write-Host "`t `t `t $([char]215) Server $Server cannot be contacted, skipped it" -ForegroundColor Red
                    $Server | Out-File -FilePath $log -Append
                    Continue
                } #if GroupInfo = $null
            $GroupInfo
        } #else Test-Connection $Server -Count 2 -Quiet
    } #Function Validate-Server
#endregion Function Validate-Server
} #begin
Process {
    Foreach ($Computer in $Name) {
        $AllRemoteGroups = Validate-Server -Server $Computer -log $Logfile
        $Hostname = $AllRemoteGroups[0].PSComputerName
        
        $Obj = New-Object -TypeName PSObject
	    $Obj.PSObject.TypeNames.Insert(0,'vGeek.GroupMembers')
        If($Computer -match "^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$") {
           #$Hostname = [System.Net.Dns]::GetHostEntry($Computer).HostName
           $Obj | Add-Member -Name ComputerName -MemberType NoteProperty -Value $Hostname
           $Obj | Add-Member -Name IPAddress -MemberType NoteProperty -Value $Computer
        } #if $computername -match ip
        Else {
            $IP = [System.Net.Dns]::GetHostEntry($Computer).AddressList.IPAddressToString -join ", " 
            $Obj | Add-Member -Name ComputerName -MemberType NoteProperty -Value $Hostname
            $Obj | Add-Member -Name IPAddress -MemberType NoteProperty -Value $IP
        } #Else
        $Filter =  "\\$Hostname\root\cimv2:Win32_Group.Domain=`"$HostName`",Name=`"$Group`""
        Foreach ($Group in $RemoteGroups) {
            $ReceivedGroup = @()
            $Filter =  "\\$HostName\root\cimv2:Win32_Group.Domain=`"$HostName`",Name=`"$Group`""
            $FilteredGroup = $AllRemoteGroups | Where-Object {$_.GroupComponent -eq $Filter}

            if ($FilteredGroup -eq $null) {
                $MemberAccount = $null
            } #if ($FilteredGroup -eq $null)
            else {
                Foreach ($Component in $FilteredGroup) {
                    $DomainName = (($Component.PartComponent -Split ".Domain=`"")[1] -split "`"")[0]
                    $MemberAccount = ($Component.PartComponent -Split "`",Name=`"").trimend("`"")[1]
                    $MemberAccount = "{0}\{1}" -f $DomainName, $MemberAccount 
                    $ReceivedGroup += $MemberAccount
                }
                
            }#if ($FilteredGroup -eq $null)

            $Obj | Add-Member -Name "$Group Members Count"-MemberType NoteProperty -Value $ReceivedGroup.Count
            $Obj | Add-Member -Name "$Group Members" -MemberType NoteProperty -Value ($ReceivedGroup| Out-String).Trim()
        }#Forech Group
    $Report += $Obj
    }#Forech $computername in $name
} #Process
End {
    $Report
}#End
} #function Get-GroupMembers

function Add-GroupMember {
<#
  .Synopsis
    Add domain user or group in local or  remote local group
  .Description
    The Add-GroupMember Check for the given user or group in remote or local group whether it exist, if it does it skips the process, if not it adds to the group
  .Example
    Add-GroupMember -ComputerName Server1, Server2, Server3 -RemoteGroup "Remote Desktop Users" -Domain vcloud -User vkunal -Credential (Get-Credential)
    Above are the complete parameters, you can assigne multiple server names in ther computername parameter, remoteGroup is 'Remote Desktop users' on Server1, Server2, Server3, and user I want to add is vcloud and vkunal, -credential is for incase your server and your machine (powershell running) are not on the same domain.
  .Example
    Add-GroupMember -ComputerName client01 -RemoteGroup Remotegroup -Domain vcloud -User vkunal
    Credential not required if my client01 and the my desktop (where i will execute this command) are on same domain.
  .Example
    Get-AdComputers -Filter * | Add-GroupMember -ComputerName client01 -RemoteGroup Remotegroup -Domain vcloud -User vkunal
  .Example
   $cred = (Get-Crendential)
   "Server001", "Server002" Add-GroupMember -RemoteGroup "Remote Desktop Users" -Domain vcloud -User vkunal -Credential $cred
   Servers can be passed from array or files, and you can specify crendetials
  .Parameter ComputerName
    It is Alias to Name parameter
    You can provide multiple computername names or single one.
  .Parameter RemoteGroups
    This is remote group name on the remote computer ie Remote Desktop Users
  .Parameter Domain
    This is Domain name where your user or group exist
  .Parameter User 
    This is user or group you will be adding to remote group.
  .Inputs
    [string]
  .Notes
    NAME:  Add-GroupMember
    AUTHOR: Kunal Udapi
    LASTEDIT: 24th October 2015
    KEYWORDS: Local Groups, Remote Local Groups
  .Link
    #Check Online version: Http://kunaludapi.blogspot.com 
    #Requires -Version 4.0
 #>

    [CmdletBinding(SupportsShouldProcess)]
    Param(
        [Parameter(Mandatory=$true, Position=1,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)]#ComputerName Parameters
        [alias("Name", "HostName")]
        [string[]]$ComputerName, 

        [Parameter(Mandatory=$true, Position=2)]
        [alias("RemoteGroupName")]
        [string]$RemoteGroup, #'Administrators',

        [Parameter(Mandatory=$true, Position=3)]
        [alias("DomainName")]   
        [string]$Domain,

        [Parameter(Mandatory=$true, Position=4)]
        [alias("UserName")]  
        [string]$User, #'Administrator',

        [System.Management.Automation.PSCredential]$Credential
    ) #Param
    
    begin {}
    Process {
    Foreach ($machine in $ComputerName) {
        if (Test-Connection $machine -Count 2 -Quiet) {
                if ($Credential -eq $null) {
                    $WINNT = "WinNT://{0}/{1},group" -f $machine, $RemoteGroup 
                    $ADSIInfo = New-Object -TypeName System.DirectoryServices.DirectoryEntry -ArgumentList $WINNT -ErrorAction SilentlyContinue
                    $userGroup = "WinNT://{0}/{1}" -f $Domain, $User
                    $ADSIInfo | Out-Null
                    if ($ADSIInfo -eq $null) {
                        Write-Host "Cannot Connect to $Server"
                    }
                    else {
                        $Status = $ADSIInfo.IsMember($userGroup)
                    }
                } #if $cred is null
                else {
                    $WINNT = "WinNT://{0}/{1},group" -f $machine, $RemoteGroup 
                    $ADSIInfo = New-Object -TypeName System.DirectoryServices.DirectoryEntry -ArgumentList $WINNT, $($Credential.UserName), $($Credential.GetNetworkCredential().password) #-ErrorAction SilentlyContinue
                    $userGroup = "WinNT://{0}/{1}" -f $Domain, $User
                    $ADSIInfo | Out-Null
                    if ($ADSIInfo -eq $null) {
                        Write-Host "Cannot Connect to $Server"
                    }
                    else {
                        $Status = $ADSIInfo.IsMember($userGroup)
                    }
                } #else $cred is null

                Switch ($status) {
                    "False" {$ADSIInfo.Add($userGroup) 
                        Write-Host "`t `t `t $([char]8730) User $domain\$User is added to the Group $remoteGroup, verify using command Get-GroupMembers" -ForegroundColor Green
                        Break}
                    
                    "True" {Write-Host "`t `t `t $([char]8734) User $domain\$User is already member of the Group $remoteGroup" -ForegroundColor Yellow
                        Break}
                    
                    $null {Write-Host "`t `t `t $([char]215) Please Provide currect Parameters" -ForegroundColor Red 
                        Break}
                }#switch $status
            } #if Test-Connection
        else {
            Write-Host "`t `t `t $([char]215) $machine is not reachable" -ForegroundColor Red
        } #else Test-connection
    } #Foreach $machine
    }#process
    end {}
} #Function Add-GroupMember

function Remove-GroupMember {
<#
  .Synopsis
    Remove domain user or group in local or remote local group
  .Description
    The Remove-GroupMember Check for the given user or group in remote or local group whether it exist, if it does it skips the process, if not it Removes from the group
  .Example
    Remove-GroupMember -ComputerName Server1, Server2, Server3 -RemoteGroup "Remote Desktop Users" -Domain vcloud -User vkunal -Credential (Get-Credential)
    Above are the complete parameters, you can assigne multiple server names in ther computername parameter, remoteGroup is 'Remote Desktop users' on Server1, Server2, Server3, and user I want to Remove is vcloud and vkunal, -credential is for incase your server and your machine (powershell running) are not on the same domain.
  .Example
    Remove-GroupMember -ComputerName client01 -RemoteGroup Remotegroup -Domain vcloud -User vkunal
    Credential not required if my client01 and the my desktop (where i will execute this command) are on same domain.
  .Example
    Get-AdComputers -Filter * | Remove-GroupMember -ComputerName client01 -RemoteGroup Remotegroup -Domain vcloud -User vkunal
  .Example
   $cred = (Get-Crendential)
   "Server001", "Server002" Remove-GroupMember -RemoteGroup "Remote Desktop Users" -Domain vcloud -User vkunal -Credential $cred
   Servers can be passed from array or files, and you can specify crendetials
  .Parameter ComputerName
    It is Alias to Name parameter
    You can provide multiple computername names or single one.
  .Parameter RemoteGroups
    This is remote group name on the remote computer ie Remote Desktop Users
  .Parameter Domain
    This is Domain name where your user or group exist
  .Parameter User 
    This is user or group you will be Removeing to remote group.
  .Inputs
    [string]
  .Notes
    NAME:  Remove-GroupMember
    AUTHOR: Kunal Udapi
    LASTEDIT: 24th October 2015
    KEYWORDS: Local Groups, Remote Local Groups
  .Link
    #Check Online version: Http://kunaludapi.blogspot.com 
    #Requires -Version 4.0
 #>

    [CmdletBinding(SupportsShouldProcess)]
    Param(
        [Parameter(Mandatory=$true, Position=1,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)]#ComputerName Parameters
        [alias("Name", "HostName")]
        [string[]]$ComputerName, 

        [Parameter(Mandatory=$true, Position=2)]
        [alias("RemoteGroupName")]
        [string]$RemoteGroup, #'Administrators',

        [Parameter(Mandatory=$true, Position=3)]
        [alias("DomainName")]   
        [string]$Domain,

        [Parameter(Mandatory=$true, Position=4)]
        [alias("UserName")]  
        [string]$User, #'Administrator',

        [System.Management.Automation.PSCredential]$Credential
    ) #Param
    
    begin {}
    Process {
    Foreach ($machine in $ComputerName) {
        if (Test-Connection $machine -Count 2 -Quiet) {
                if ($Credential -eq $null) {
                    $WINNT = "WinNT://{0}/{1},group" -f $machine, $RemoteGroup 
                    $ADSIInfo = New-Object -TypeName System.DirectoryServices.DirectoryEntry -ArgumentList $WINNT -ErrorAction SilentlyContinue
                    $userGroup = "WinNT://{0}/{1}" -f $Domain, $User
                    $ADSIInfo | Out-Null
                    if ($ADSIInfo -eq $null) {
                        Write-Host "Cannot Connect to $Server"
                    }
                    else {
                        $Status = $ADSIInfo.IsMember($userGroup)
                    }
                } #if $cred is null
                else {
                    $WINNT = "WinNT://{0}/{1},group" -f $machine, $RemoteGroup 
                    $ADSIInfo = New-Object -TypeName System.DirectoryServices.DirectoryEntry -ArgumentList $WINNT, $($Credential.UserName), $($Credential.GetNetworkCredential().password) #-ErrorAction SilentlyContinue
                    $userGroup = "WinNT://{0}/{1}" -f $Domain, $User
                    $ADSIInfo | Out-Null
                    if ($ADSIInfo -eq $null) {
                        Write-Host "Cannot Connect to $Server"
                    }
                    else {
                        $Status = $ADSIInfo.IsMember($userGroup)
                    }
                } #else $cred is null

                Switch ($status) {
                    "True" {$ADSIInfo.Remove($userGroup) 
                        Write-Host "`t `t `t $([char]8730) User $domain\$User is Removed from the Group $remoteGroup, verify using command Get-GroupMembers" -ForegroundColor Green
                        Break}
                    
                    "False" {Write-Host "`t `t `t $([char]8734) User $domain\$User is not the member of the Group $remoteGroup" -ForegroundColor Yellow
                        Break}
                    
                    $null {Write-Host "`t `t `t $([char]215) Please Provide currect Parameters" -ForegroundColor Red 
                        Break}
                }#switch $status
            } #if Test-Connection
        else {
            Write-Host "`t `t `t $([char]215) $machine is not reachable" -ForegroundColor Red
        } #else Test-connection
    } #Foreach $machine
    }#process
    end {}
} #Function Remove-GroupMember

Export-ModuleMember Get-GroupMembers
Export-ModuleMember Add-GroupMember
Export-ModuleMember Remove-GroupMember