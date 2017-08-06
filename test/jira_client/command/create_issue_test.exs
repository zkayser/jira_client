defmodule JiraClient.Command.CreateIssueTest do
  use ExUnit.Case
  doctest JiraClient.Command.CreateIssue

  alias JiraClient.Command.CreateIssue

  describe "Success" do

    test "create issue" do

      CreateIssue.run(%{project: "PROJECT X", fix_version: "1.2.3", message: "MESSAGE 1" })
    end
  end
end
