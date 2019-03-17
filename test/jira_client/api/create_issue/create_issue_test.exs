defmodule JiraClient.Api.CreateIssueTest do
  use ExUnit.Case
  doctest JiraClient.Api.CreateIssue

  alias JiraClient.Api.CreateIssue
  alias JiraClient.Http.RequestFake

  setup do
    RequestFake.init()
  end

  test "send request" do
    RequestFake.expect_response(~s(echo some request))

    {:ok, response} = CreateIssue.send(%{}, "some request")

    assert {:post, "some request", "rest/api/latest/issue", %{}} == RequestFake.next_request()
    assert "echo some request" == response
  end
end
