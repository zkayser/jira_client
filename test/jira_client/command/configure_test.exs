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
    {:ok, result} = Configure.run_with_password(%Args{username: "fred"}, fn -> "secret" end)

    assert result == "Configuration complete"
  end

  test "read password from stdin" do
    {:ok, _} = Configure.run_with_password(%Args{username: "fred"}, fn -> "secret" end)

    assert {:ok, Base.encode64("fred:secret")} == FileUtils.read_credentials()
  end
end

