#!/bin/bash

project=
message=

positionalArg=1
while [[ $# -gt 0 ]]; do
  if [[ $1 == "--project" ]]; then
    shift
    project=$1
  elif [[ $1 == "--message" ]]; then
    shift
    message=$1
  fi
  shift
done


issue_id=`jira_client create_issue --project "$project" --message "$message"`
if [[ $? -eq 0 ]]; then
  if [[ `uname` == "Darwin" ]]; then
    echo -n $issue_id | pbcopy
  fi

  echo "Issue ${issue_id}"
  jira_client close_issue --issue "$issue_id"
fi

