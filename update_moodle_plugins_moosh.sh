#!/bin/bash 
while IFS= read -r line; do
   moosh plugins-install $line
done < plugins.txt 
