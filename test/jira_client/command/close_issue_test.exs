defmodule JiraClient.Command.CloseIssueTest do
  use ExUnit.Case
  doctest JiraClient.Command.CloseIssue

  alias JiraClient.Args

  test "execution" do
    {:ok, message} = JiraClient.Command.CloseIssue.run(Args.parse(["close_issue", "-i", "XXX-123"]))

    assert message
  end
end
