#New-VIPermission -Principal NA\UU-Team5 -Role Readonly -Propagate:$false -Entity Datacenters
#New-VIPermission -Principal NA\UU-Team5 -Role Readonly -Propagate:$false -Entity "UU Stealth Training LAB"
#New-VIPermission -Principal NA\UU-Team5 -Role Readonly -Propagate:$false -Entity "UU Sandbox"
#New-VIPermission -Principal NA\UU-Team5 -Role Readonly -Propagate:$false -Entity "172.22.242.149"
New-VIPermission -Principal NA\UU-Team5 -Role VirtualMachineUser -Propagate:$true -Entity "Team5"