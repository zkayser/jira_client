defmodule JiraClient.Api.CloseIssueRequestTest do
  use ExUnit.Case
  alias JiraClient.Args
  alias JiraClient.Api.CloseIssueRequest

  test "Formats args" do
    expected = ~s({"transitions": {"id": "5"}})

    CloseIssueRequest.format(%Args{close_transition: "5"}) == expected
  end
end
