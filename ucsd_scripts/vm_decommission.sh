#!/bin/bash
# Decommission expired VMs from UCSD and vCenter
# UCSD does not have functionality to decommission expired VMs hence this script with work with the VM archival script to decommission expired VMs

# Variables :
# RESTKEY : UCSD Rest key ( from advanced settings in user profile )
RESTKEY=5CAF2010133942E98E0895691766AD1E
# GRACEDAYS : Number of days the VMs expired in the past.
GRACEDAYS=15

        for vm in `/opt/infra/bin/dbAdmin.sh exec-query "SELECT VMID FROM VMWAREVM_SUMMARY_VIEW WHERE SCHEDULEDTERMINATIONTIME > 0 AND SCHEDULEDTERMINATIONTIME < ( UNIX_TIMESTAMP(NOW()) - ( $GRACEDAYS * 86400 ) )*1000 AND POWERSTATUS = 'OFF' ORDER BY SCHEDULEDTERMINATIONTIME;" | egrep "[0123456789]"`
	do
		# Use rest api call to delete the VM.
                curl -k -v -H "X-Cloupia-Request-Key:$RESTKEY" -X POST -G 'https://127.0.0.1/app/api/rest' --data-urlencode "format=json" --data-urlencode "opName=userAPIExecuteVMAction" --data-urlencode "opData={param0:$vm,param1:\"destroyVM\",param2:\"Archived and Decommissioned\"}" >> Decommission.log 2>&1
                # Show curl return code(this is not the request http response code) 
		echo For VMID $vm : curl finished with rc : $?
        done

