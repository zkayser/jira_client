defmodule JiraClient.Api.FormatterTest do
  use ExUnit.Case

  defmodule RequestTestFake do
    @behaviour JiraClient.Api.Formatter
    def format(request) do
      inspect request
    end
  end

  test "implements request callback" do
    assert "%{value: \"some parameter\"}" == RequestTestFake.format(%{value: "some parameter"})
  end
end
