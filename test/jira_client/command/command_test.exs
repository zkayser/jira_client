defmodule JiraClient.CommandTest do
  use ExUnit.Case
  doctest JiraClient.Command

  defmodule DoSomething do
    def run(args) do
      hd(args)
    end
  end

  test "Run a command" do
    {:ok, result} = JiraClient.Command.run(JiraClient.CommandTest, "do_something", ["hello world"])

    assert result == "hello world"
  end
end
