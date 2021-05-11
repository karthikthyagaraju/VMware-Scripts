#!/bin/bash
rm -rf /root/scripts/expiredvms.csv
mysql -u root db_private_admin < /root/scripts/mysqlscript.sql
