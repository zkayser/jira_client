defmodule JiraClient.Api.ResponseTest do
  use ExUnit.Case
  doctest JiraClient.Api.Response

  defmodule ResponseTestFake do
    @behaviour JiraClient.Api.Response

    def parse(response) do
      %{value: response}
    end
  end

  test "impleement the response behavior" do
    assert %{value: "fred"} == ResponseTestFake.parse("fred")
  end
end
