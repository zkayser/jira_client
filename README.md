# JiraClient

A **Jira** command line client that allows developers to work with the issue tracking tool
while developing code. Specifically addresses the problem of including a **Jira** issue
number in a commit message.

Usage:
```bash

$ jira_client create_issue -m "change code to make it better" -p "Project Name" -m "Fix Version"
Issue created: XXX-123
```

Once a set of commits are complete for an issue the issue can be closed.

```bash

$ jira_client close_issue -i XXX-123
Issue closed: XXX-123
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `jira_client` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:jira_client, "~> 0.1"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/jira_client](https://hexdocs.pm/jira_client).
