# JiraClient

![Travis build](https://travis-ci.org/zkayser/jira_client.svg?branch=master
"Build Status")

A **Jira** command line client that allows developers to work with the issue tracking tool
while developing code. Specifically addresses the problem of including a **Jira** issue
number in a commit message.

## Installation

Generate the executable

    MIX_ENV=prod mix escript.build

Generates the command

    bin/jira_client

## Usage

Start by getting help

```bash
$ jira_client help

usage: jira_client [command] [arguments]

      Commands:
      configure --username "esumerfield"
      list_projects
      create_issue --project "PROJECT A" --message "this is an issue" [--fixVersion "1.2.3"]
      close_issue --issue "ABC-123"
      assign --issue "ABC-123" --username <your jira username>

      Common arguments for all commands
      [--logging] can be added to produce API logging.
```

Create a config file in your home dir (.jira/credentials.txt) to hold your jira credenitals.

```bash
$ jira_client configure --username <jira username>

Enter JIRA domain (https://YOURCOMPANY.atlassian.net) ***********
Enter JIRA passwod: **********
```

Create an issue.

```bash
$ jira_client create_issue -m "change code to make it better" -p "Project Name"
XXX-123
```

Assign the issue to someone:

```bash
$ jira_client assign --issue XXX-123 --username <jira username>
Assigned
```

Once a set of commits are complete for an issue the issue can be closed.

```bash
$ jira_client close_issue -i XXX-123
Closed
```

Also there are scripts that support a combination of jira integrations. This script
creates an issue, places the issue id in the clipboard, assigns it, and closes it. This cleans up the
jira tracking side and allows you to commit against the issue.

```bash
$ track_change.sh --project "Project Name" --username <jira username> --message "change code to make it better"
XXX-123
Assigned
Closed
```

## Bash Alises

To make life easier you can generate aliases for use with all your projects. The jira client gets a list of
all your projects and creates an alias for each. Add the generated file to your login profile.

The pattern is simple, jci<project key> to create an issue, or tc<project key> to use the track change process.

For example:

```bash
alias jcipandroid='jira_client create_issue --project "Product: Android" --message '
alias tcpandroid='track_change.sh --project "Product: Android" --username <jira username> --message '
```

```bash
$ generate_aliases.sh --filter Product --username `whoami`
Jira aliases generated
Add ~/.jira_aliases to your .bashrc file.
```

## Future command ideas

* List fix versions for a project.
* Initiate workflow event for issue.

## Future Developer Workflow

Each developer must attend to change tracking against the story they are working on. This flow 
requires the following basic steps:

* Identify the project story id of the story to be completed.
* Change the apprppriate code.
* Create a product change id to associate the code changes.
* Commit the code changes with the product change id.
* Repeat code changes and committing to product change id's as needed.
* Associate product change id with project story id.

These steps can be optimized into the following flow:

* Identity and remember the project story id.
* Change the appropriate code.
* Commit change with new product change id that is associated with project story id.

This limits the developers work to two administrative steps allowing more focused time on coding.

This might follow this command sequence:

```bash
$ track_story STORY_ID | "Story summary"
$ vi ...
$ track_change "refactor bad code to make it good"
$ vi ...
$ track_change "refactor more bad code to make it good"
$ vi ...
$ track_change "refactor more bad code to make it good"
$ go home.
```

## References

* JIRA API doc: https://docs.atlassian.com/jira/REST/cloud/

