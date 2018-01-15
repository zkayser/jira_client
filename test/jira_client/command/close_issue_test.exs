defmodule JiraClient.Command.CloseIssueTest do
  use ExUnit.Case
  doctest JiraClient.Command.CloseIssue

  alias JiraClient.Args
  alias JiraClient.Http.RequestFake

  setup do
    RequestFake.init()
  end

  describe "success" do
    test "close issue" do
      RequestFake.expect_response(%HTTPotion.Response{body: ~s({
        "transitions": [
          {
            "id": "2",
            "name": "Done"
          }
        ]
      }
      )})

      RequestFake.expect_response(%HTTPotion.Response{body: ~s({
        "id": "10000",
        "key": "TST-24",
        "self": "http://www.example.com/jira/rest/api/2/issue/10000"
      }
      ),
      status_code: 200})

      {:ok, args} = Args.parse(["close_issue", "-i", "XXX-123"])
      {:ok, message} = JiraClient.Command.CloseIssue.run(args)

      assert message
    end
  end
end
