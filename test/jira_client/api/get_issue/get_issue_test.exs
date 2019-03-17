defmodule JiraClient.Api.GetIssueTest do
  use ExUnit.Case

  alias JiraClient.Api.GetIssue
  alias JiraClient.Http.RequestFake

  setup do
    RequestFake.init()
  end

  test "send request" do
    RequestFake.expect_response(%HTTPotion.Response{body: ~s({"id":"12345"})})

    {:ok, response} = GetIssue.send(%{issue: "ABC-123"}, "")

    assert {:get, "", "/rest/api/2/issue/ABC-123", %{}} == RequestFake.next_request()
    assert response.body =~ "12345"
  end
 
end

