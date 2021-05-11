#!/bin/bash
rm -rf /root/scripts/newexpiredvms.csv
mysql -u root db_private_admin < /root/scripts/test.sql
