#!/bin/bash
# ################################################################################
# Generate aliases for all the projects in jira
# ################################################################################

aliasFile=~/.jira_aliases

mv -f $aliasFile $aliasFile.old

foundCodes=
jira_client list_projects | while read projectName; do
  projectName=`echo $projectName | tr -d '\n\r'`

  # Strip bad characters
  projectName=`echo $projectName | tr -d '&'`

  # Generate an alias projectName.
  set -- $projectName
  code=
  while [[ $# -gt 0 ]]; do
    letter=`echo ${1:0:1} | tr 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' 'abcdefghijklmnopqrstuvwxyz'`
    code=${code}${letter}
    shift
  done

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

  echo "alias tc${code}='track_change.sh --project \"${projectName}\" --message '" >> $aliasFile
  echo "alias jct${code}='jira_client create_issue --project \"${projectName}\" --message '" >> $aliasFile

  foundCodes=$foundCodes,$code
done

echo "Jira aliases generated"
echo "Add ~/.jira_aliases to your .bashrc file."

