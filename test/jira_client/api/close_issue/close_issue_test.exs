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

    {:ok, response} = CloseIssue.send(%{id: 123}, "some request")

    assert {:post, "some request", "/rest/api/latest/issue/123/transitions"} == RequestFake.next_request()
    assert "some response" == response
  end
end

