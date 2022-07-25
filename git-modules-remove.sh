#!/bin/bash

projectpath='/var/www/moodle/modules/'
gitconfig=${projectpath}'.git/config'
gitmodules=${projectpath}'.gitmodules'
declare -a modulepathes

#get submodules pathes
while read line; do
  # reading each line
  if [[ ${line} == *"path ="* ]] ; then
  modulepathes+=(${line#*path = })
  fi
done < ${gitmodules}

#remove gitmoudules conf
rm ${gitmodules}

for modulepath in ${modulepathes[@]}
do
  #clear git cache for every module
  cd ${projectpath} && git rm --cached ${modulepath}
  echo ${modulepath}
  #remove .git folder from each module
  rm -rf ${projectpath}${modulepath}'/.git'

done

cd ${projectpath} && git add . && git commit -m "remove submodules"

##find ${projectpath} -exec -rm -rf '.git' + {}



