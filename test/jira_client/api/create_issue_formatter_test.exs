defmodule JiraClient.Api.CreateIssueFormatterTest do
  use ExUnit.Case
  doctest JiraClient.Api.CreateIssueFormatter

  alias JiraClient.Api.CreateIssueFormatter

  test "format request" do
    expected = ~s({"fields":{"summary":"REST ye merry gentlemen.","project":{"key":"ABC-123"},"issuetype":{"name":"Task"},\"fixVersions\":[{\"id\":\"1.2.3\"}]}})

    assert {:ok, expected} == CreateIssueFormatter.format(%{project_id: "ABC-123", fix_version: "1.2.3", message: "REST ye merry gentlemen."})
  end
end
