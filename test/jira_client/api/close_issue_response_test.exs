defmodule JiraClient.Api.CloseIssueResponseTest do
  use ExUnit.Case
  alias JiraClient.Api.CloseIssueResponse

  test "parse response" do
    json = ~s({
      "key": "TST-24"
    })

    {:ok, response} = CloseIssueResponse.parse(%HTTPotion.Response{body: json, status_code: 204})

    assert response.issue_id == "TST-24"
  end
end
