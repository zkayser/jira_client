defmodule JiraClient.Api.SenderTest do
  use ExUnit.Case

  defmodule SenderTestFake do
    @behaviour JiraClient.Api.Sender
    def send(attributes, body, _ \\ false) do
      {:ok, attributes, %{body: body}}
    end
  end
  
  test "implements callback" do
    assert {:ok, %{attribute: 123}, %{body: "name=value"}} == SenderTestFake.send(%{attribute: 123}, "name=value")
  end
end

