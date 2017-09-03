defmodule JiraClient.Api.CloseIssueFormatterTest do
  use ExUnit.Case
  alias JiraClient.Args
  alias JiraClient.Api.CloseIssueFormatter

  test "Formats args" do
    expected = ~s({"transitions":{"id":"5"}})

    assert {:ok, expected} == CloseIssueFormatter.format(%Args{close_transition: "5"})
  end
end
