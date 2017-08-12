defmodule JiraClient.Command.ConfigureTest do
  use ExUnit.Case
  doctest JiraClient.Command.Configure

  alias JiraClient.Command.Configure
  alias JiraClient.Args

  setup do
    JiraClient.Utils.FileMock.start_link()
    :ok
  end

  test "running configuration" do
    {:ok, result} = Configure.run(%Args{username: "fred", password: "secret"})

    assert result == "Configuration complete"
  end
end
