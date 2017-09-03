defmodule JiraClient.Api.CreateIssueParserTest do
  use ExUnit.Case
  doctest JiraClient.Api.CreateIssueParser

  alias JiraClient.Api.CreateIssueParser

  test "parse response" do
    json = ~s({
        "id": "10000",
        "key": "TST-24",
        "self": "http://www.example.com/jira/rest/api/2/issue/10000"
    })

    {:ok, response} = CreateIssueParser.parse(json)

    assert response.issue_id == "TST-24"
  end
end
