defmodule JiraClient.Api.RequestTest do
  use ExUnit.Case

  defmodule RequestTestFake do
    @behaviour JiraClient.Api.Request
    def format(request) do
      inspect request
    end
  end

  test "implements request callback" do
    assert "%{value: \"some parameter\"}" == RequestTestFake.format(%{value: "some parameter"})
  end
end
