defmodule JiraClient.Command.ConfigureTest do
  use ExUnit.Case
  doctest JiraClient.Command.Configure

  alias JiraClient.Command.Configure
  alias JiraClient.Args
  alias JiraClient.Utils.FileUtils

  setup do
    JiraClient.Utils.FileMock.start_link()
    :ok
  end

  test "running configuration" do
    {:ok, result} = Configure.run(%Args{username: "fred", password: "secret"})

    assert result == "Configuration complete"
  end

  @tag :skip
  test "read password from stdin" do
    {:ok, _} = Configure.run(%Args{username: "fred"})

    IO.puts(">>>> #{FileUtils.get_creds_file()}")
    IO.puts(">>>> #{FileUtils.get()}")

    assert FileMock.exists?(FileUtils.get_creds_file())
  end
end

