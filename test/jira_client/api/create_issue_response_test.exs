defmodule JiraClient.Api.CreateIssueResponseTest do
  use ExUnit.Case
  doctest JiraClient.Api.CreateIssueResponse

  alias JiraClient.Api.CreateIssueResponse

  @tag skip: "not implemented yet"
  test "parse response" do
    CreateIssueResponse.parse("asdfasdasdf")
  end
end
