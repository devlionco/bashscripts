#!/bin/bash 
while IFS= read -r line; do
   echo -e "**********************************************"
   echo  -e "\ntry" $line
   moosh -n  plugin-install -f  $line
done < plugins.txt

