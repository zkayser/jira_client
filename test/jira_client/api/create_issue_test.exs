defmodule JiraClient.Api.CreateIssueTest do
  use ExUnit.Case
  doctest JiraClient.Api.CreateIssue

  alias JiraClient.Api.CreateIssue

  test "send request" do
    {:ok, response} = CreateIssue.send("some request")

    assert "echo some request" == response
  end
end
