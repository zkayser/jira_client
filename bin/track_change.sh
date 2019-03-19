#!/bin/bash

function usage {
  message=$@

  echo "Missing $message"
  echo "usage: `basename $0` --project NAME --message MESSAGE --username [jira user name]"
  exit 1
}

project=
message=
username=`whoami`

positionalArg=1
while [[ $# -gt 0 ]]; do
  if [[ $1 == "--project" ]]; then
    shift
    project=$1
  elif [[ $1 == "--username" || $1 == "-u" ]]; then
    shift
    username=$1
  elif [[ $1 == "--message" ]]; then
    shift
    message=$1
  fi
  shift
done

if [[ -z $project ]]; then
  usage "project id"
elif [[ -z $message ]]; then
  usage "message"
fi

issue_id=`jira_client create_issue --project "$project" --message "$message"`
if [[ $? -eq 0 && -n $issue_id ]]; then
  if [[ `uname` == "Darwin" ]]; then
    echo -n "$issue_id $message" | pbcopy
  fi

  jira_client assign --issue "$issue_id" --username $username
  jira_client close_issue --issue "$issue_id"

  echo "Issue ${issue_id}"
else
  echo "Something went wrong"
fi

