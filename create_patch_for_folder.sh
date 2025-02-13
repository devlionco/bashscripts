#!/bin/bash
#

# !!!Please change git commands for your system.!!!

cd petel41

path="question/type/numerical" 
#path="question/type/formulas" 
#path="theme/boost_union" 
#path="mod/quiz/report/advancedoverview" 



# Revert git.
git reset --hard
git checkout prod_m41
git branch -D dev_m41X_petel
git branch dev_m41X_petel
git checkout dev_m41X_petel


# =================================================================================================

# Clear screen
clear

# Variables
declare -a ARRAY_HASHES=()
Red='\033[0;31m' 
Green='\033[0;32m' 
Blue='\033[0;34m' 
Orange='\033[0;33m'
NoColor='\033[0m' # No Color

# Get history hashes.
for sha1 in $(git log --format=format:%H -1000 -- $path); do : 	
	ARRAY_HASHES+=("$sha1")  
done

# Print hashes with description and autor.
for hash in "${ARRAY_HASHES[@]}"
do :
   
   printf '\033[1A\033[K'
   
   description=$(git log $hash --format="%B" -n 1)
   
   if [[ "$description" == *"MDL-"* ]];  then
		echo -e "${Blue} ${hash} ${Red}- ${description} ${NoColor}"
	 else
		echo -e "${Blue} ${hash} ${Green}- ${description} ${NoColor}"
   fi  
   
   
   author=$(git log $hash --format="%an     (%ae)" -n 1)
   
   echo -e "${Orange} ${author} ${NoColor}"   
   echo -e ""
   
   # Wait for next commit.
   read -r -p "Do you want next commit? Press enter or 'q' for quit: " response
   
   if [[ "$response" == q ]];  then	
	 break
   fi   
done

# Create patch.
printf '\033[1A\033[K'

echo -e ""
read -r -p "Please enter hash for create patch: " hashpatch

# Exit if empty string
if [ -z "$hashpatch" ]; then		  
	exit
fi


# Reset soft to commit.
process=$(git reset --soft $hashpatch)

# Commit changes for patch.
commit="git commit -m '$path' -- $path"
process=$(${commit})

#process=$(git commit -m 'message' -- $path)

for sha2 in $(git log --format=format:%H -1 -- $path); do : 		
	break
done

#echo "${sha2}"

git format-patch -1 $sha2


#git format-patch -o "C:/OpenServer1/domains" 5c9a2075aaa65a9ce26ca4b699c66c6689c40eca
