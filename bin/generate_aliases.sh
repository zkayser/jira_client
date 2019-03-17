#!/bin/bash
# ################################################################################
# Generate aliases for all the projects in jira
# ################################################################################

function usage {
  echo "usage: `basename $0` [--filter PATTERN]"
  exit 1
}

filter=
username=`whoami`

while [[ $# -gt 0 ]]; do
  if [[ $1 == --help || $1 == -h ]]; then
    usage
  elif [[ $1 == "--username" || $1 == "-u" ]]; then
    shift
    username=$1
  elif [[ $1 == --filter || $1 == -f ]]; then
    shift
    filter=$1
  fi
  shift
done

aliasFile=~/.jira_aliases

if [[ -f $aliasFile ]]; then
  mv -f $aliasFile $aliasFile.old
fi

foundCodes=
jira_client list_projects | \
  while read projectDetails; do

    if [[ -n $filter && $projectDetails != *$filter* ]]; then
      continue
    fi

    projectName=`echo $projectDetails | cut -d'(' -f1 | tr -d '\n\r'`
    projectKey=`echo $projectDetails | cut -d'(' -f2 | cut -d')' -f1 | tr -d '\n\r'`

    # Strip bad characters
    projectName=`echo $projectName | tr -d '&'`

    code=`echo $projectKey | tr 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' 'abcdefghijklmnopqrstuvwxyz'`

    # Make sure the alias projectName is unique
    next=1
    itsUnique=false
    uniqueCode=$code
    while [[ $itsUnique == "false" ]]; do
      if [[ $foundCodes == *$uniqueCode* ]]; then
        uniqueCode=${code}${next}
        ((next=$next+1))
      else
        itsUnique="true"
      fi
    done
    code=$uniqueCode

    echo "alias tc${code}='track_change.sh --project \"${projectName}\" --username $username --message '" >> $aliasFile
    echo "alias jct${code}='jira_client create_issue --project \"${projectName}\" --message '" >> $aliasFile

    foundCodes=$foundCodes,$code
  done

if [[ -f $aliasFile ]]; then
  sort $aliasFile > $aliasFile.sorted
  mv -f $aliasFile.sorted $aliasFile

  echo "Jira aliases generated"
  echo "Add ~/.jira_aliases to your .bashrc file."
else
  echo "No projects matched filter"
fi

