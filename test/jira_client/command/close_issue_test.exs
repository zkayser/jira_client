defmodule JiraClient.Command.CloseIssueTest do
  use ExUnit.Case
  doctest JiraClient.Command.CloseIssue

  alias JiraClient.Args

  test "execution" do
    JiraClient.Command.CloseIssue.run(Args.parse(["create_issue", "-p", "PROJECT A", "-f", "1.2.3", "-m", "MESSAGE 1"]))
  end
end
