#!/bin/bash
git ls-files rules | grep -e ".yaml" | while read path
do
  if [ "$(git log --since "24 hour ago" -- ${path})" != "" ]
  then
    echo "${path}"
  else
    rm -vf  "${path}"
  fi
done

#Oneliner to test the above
#git ls-files dashboards | grep -e ".json" | while read path; do if [ "$(git log --since "24 hour ago" -- ${path})" != "" ]; then echo "${path}"; else rm -vf  ${path} ;fi done;
