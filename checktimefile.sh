#!/bin/bash

path="/var/www/"
subject="Alert"
message="Alert"
tomail="kiril@devlion.co"
diftime="86400"

for file in `ls -l | awk '{print $9}'`
 do
    if [ `date -d "now - $( stat -c "%Y" ${file} ) seconds" +%s` -gt ${diftime} ]
      then
         echo "${message}" | mail -s "${subject}" ${tomail}
         exit
    else
      echo "${file} create `date -d "now - $( stat -c "%Y" ${file} ) seconds" +%s` sec "
    fi
done
