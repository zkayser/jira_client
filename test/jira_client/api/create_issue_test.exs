defmodule JiraClient.Api.CreateIssueTest do
  use ExUnit.Case
  doctest JiraClient.Api.CreateIssue

  alias JiraClient.Api.CreateIssue

  @tag skip: "need to mock the send"
  test "send request" do
    {:ok, response} = CreateIssue.send("some request")

    IO.puts(">>>> #{response}")
  end
end
