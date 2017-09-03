defmodule JiraClient.Api.CloseIssueParserTest do
  use ExUnit.Case

  alias JiraClient.Api.CloseIssueParser

  test "parse response" do
    json = ~s({
      "key": "TST-24"
    })

    {:ok, response} = CloseIssueParser.parse(%HTTPotion.Response{body: json, status_code: 204})

    assert response.issue_id == "TST-24"
  end
end
