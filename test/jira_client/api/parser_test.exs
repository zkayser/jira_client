defmodule JiraClient.Api.ParserTest do
  use ExUnit.Case
  doctest JiraClient.Api.Parser

  defmodule ParserTestFake do
    @behaviour JiraClient.Api.Parser

    def parse(response) do
      %{value: response}
    end
  end

  test "impleement the response behavior" do
    assert %{value: "fred"} == ParserTestFake.parse("fred")
  end
end
