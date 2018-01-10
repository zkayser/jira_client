defmodule JiraClient.Api.CloseIssueParserTest do
  use ExUnit.Case

  alias JiraClient.Api.CloseIssueParser

  test "parse response" do
    {:ok, "Success"} = CloseIssueParser.parse(%HTTPotion.Response{body: "", status_code: 200})
  end

  test "parse response no content" do
    {:ok, "Success"} = CloseIssueParser.parse(%HTTPotion.Response{body: "", status_code: 204})
  end

  test "parse response not found" do
    {:error, "No issue found"} = CloseIssueParser.parse(%HTTPotion.Response{body: "", status_code: 404})
  end
end
