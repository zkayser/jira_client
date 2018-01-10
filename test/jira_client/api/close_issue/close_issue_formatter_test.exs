defmodule JiraClient.Api.CloseIssueFormatterTest do
  use ExUnit.Case
  alias JiraClient.Api.CloseIssueFormatter

  test "Formats args" do
    expected = ~s({"transitions":{"id":"5"}})

    assert {:ok, expected} == CloseIssueFormatter.format(%{transition_id: "5"})
  end
end
