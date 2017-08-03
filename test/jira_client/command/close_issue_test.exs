defmodule JiraClient.Command.CloseIssueTest do
  use ExUnit.Case
  doctest JiraClient.Command.CloseIssue

  test "execution" do
    JiraClient.Command.CloseIssue.run(%{})
  end
end
