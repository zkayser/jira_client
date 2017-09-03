defmodule JiraClient.Api.CloseIssueTest do
  use ExUnit.Case
  doctest JiraClient.Api.CloseIssue

  alias JiraClient.Api.CloseIssue
  alias JiraClient.Http.RequestFake

  setup do
    RequestFake.init()
  end

  # TODO The send breaks that Sender calling convension. We propbably need to refactor to a url and a body interface.
  @tag :skip
  test "send request" do
    RequestFake.expect_response(~s(some response))

    {:ok, response} = CloseIssue.send("some request")

    assert "some response" == response
  end
end

