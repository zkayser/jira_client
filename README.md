# JiraClient

![Travis build](https://travis-ci.org/zkayser/jira_client.svg?branch=master
"Build Status")

A **Jira** command line client that allows developers to work with the issue tracking tool
while developing code. Specifically addresses the problem of including a **Jira** issue
number in a commit message.

## Installation

Generate the executable

> MIX_ENV=prod mix escript.build

Generates the command

> bin/jira_client

## Usage

Create a config file in your home dir (.jira/credentials.txt) to hold your jira credenitals.

```bash
jira_client configure --username <jira username>
```

Create an issue.

```bash
$ jira_client create_issue -m "change code to make it better" -p "Project Name"
Issue created: XXX-123
```

Once a set of commits are complete for an issue the issue can be closed.

```bash
$ jira_client close_issue -i XXX-123
Issue closed: XXX-123
```

## Future command ideas

* List fix versions for a project.
* Assign issue to me
* Initiate workflow event for issue.

## Developer Workflow

Each developer must attend to change tracking against the story they are working on. This flow 
requires the following basic steps:

* Identity the project story id of the story to be completed.
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

