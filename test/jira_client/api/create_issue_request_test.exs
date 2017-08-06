defmodule JiraClient.Api.CreateIssueRequestTest do
  use ExUnit.Case
  doctest JiraClient.Api.CreateIssueRequest

  alias JiraClient.Api.CreateIssueRequest

  test "format request" do
    expected = ~s({"fields":{"summary":"REST ye merry gentlemen.","project":{"key":"ABC-123"},"issuetype":{"name":"Task"},\"fixVersions\":[{\"id\":\"1.2.3\"}]}})

    assert {:ok, expected} == CreateIssueRequest.format(%{project_key: "ABC-123", fix_version: "1.2.3", message: "REST ye merry gentlemen."})
  end
end
