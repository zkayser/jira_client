defmodule JiraClient.Command.ConfigureTest do
  use ExUnit.Case
  doctest JiraClient.Command.Configure

  alias JiraClient.Auth.Configurations
  alias JiraClient.Command.Configure
  alias JiraClient.Args

  setup do
    JiraClient.Utils.FileMock.start_link()
    :ok
  end

  test "running configuration" do
    {:ok, result} = Configure.run_with_password(%Args{username: "fred"}, fn -> "secret" end)

    assert result == "Configuration complete"
  end

  test "configure with password with no carriage return line feed" do
    {:ok, _} = Configure.run_with_password(%Args{username: "fred"}, fn -> "secret\r\n" end)

    assert "ZnJlZDpzZWNyZXQ=" == Configurations.get() 
  end

  test "read password from stdin" do
    {:ok, _} = Configure.run_with_password(%Args{username: "fred"}, fn -> "secret" end)

    assert  Base.encode64("fred:secret") == Configurations.get() 
  end
end

