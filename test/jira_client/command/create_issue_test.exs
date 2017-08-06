defmodule JiraClient.Command.CreateIssueTest do
  use ExUnit.Case
  doctest JiraClient.Command.CreateIssue

  alias JiraClient.Command.CreateIssue

  describe "Success" do

    @tag skip: "not implemented yet."
    test "create issue" do
      result = CreateIssue.run(%{project_key: "ABC-123", fix_version: "1.2.3", message: "MESSAGE 1" })

      # assert result.issue_id == "ISSUE-123"

      IO.puts(">>>> #{inspect result}")
    end
  end
end
