defmodule JiraClient.Api.SenderTest do
  use ExUnit.Case

  defmodule SenderTestFake do
    @behaviour JiraClient.Api.Sender
    def send(request) do
      {:ok, %{value: request}}
    end
  end
  
  test "implements callback" do
    assert {:ok, %{value: "request"}} == SenderTestFake.send("request")
  end
end

