defmodule JiraClient.Api.CloseIssueRequestTest do
  use ExUnit.Case
  alias JiraClient.Args
  alias JiraClient.Api.CloseIssueRequest

  test "Formats args" do
    expected = ~s({"transitions":{"id":"5"}})

    assert {:ok, expected} == CloseIssueRequest.format(%Args{close_transition: "5"})
  end
end
