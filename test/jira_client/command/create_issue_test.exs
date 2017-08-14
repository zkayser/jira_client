defmodule JiraClient.Command.CreateIssueTest do
  Code.require_file("test/jira_client/http/request_fake.ex")
  use ExUnit.Case
  doctest JiraClient.Command.CreateIssue

  alias JiraClient.Command.CreateIssue
  alias JiraClient.Args
  alias JiraClient.Http.RequestFake

  setup do
    RequestFake.init()
  end

  describe "Success" do

    test "create issue" do
      RequestFake.expect_response(~s(
        {
          "id": "10000",
          "key": "ISSUE-123",
          "self": "http://www.example.com/jira/rest/api/2/issue/10000"
        }))

        {:ok, message} = CreateIssue.run(%Args{project: "ABC-123", fix_version: "1.2.3", message: "MESSAGE 1" })

      assert "Created ISSUE-123" == message
    end
  end
end
