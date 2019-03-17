defmodule JiraClient.Api.CloseIssueTest do
  use ExUnit.Case
  doctest JiraClient.Api.CloseIssue

  alias JiraClient.Api.CloseIssue
  alias JiraClient.Http.RequestFake

  setup do
    RequestFake.init()
  end

  test "send request" do
    RequestFake.expect_response(~s(some response))

    {:ok, _response} = CloseIssue.send(%{issue_id: 123}, "")

    assert {:post, "", "/rest/api/latest/issue/123/transitions", %{}} == RequestFake.next_request()
  end
end

