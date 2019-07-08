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
    {:ok, result} = Configure.run_with_inputs(%Args{username: "fred"}, fn -> ["secret", "http://someserver"] end)

    assert result == "Configuration complete"
  end

  test "configure with api token with no carriage return line feed" do
    {:ok, _} = Configure.run_with_inputs(%Args{username: "fred"}, fn -> ["secret\r\n", "http://someserver\r\n"] end)

    config = Configurations.get()

    assert "ZnJlZDpzZWNyZXQ=" == config.base64_encoded
    assert "http://someserver" == config.jira_server
  end

  test "read api token and jira_server from stdin" do
    {:ok, _} = Configure.run_with_inputs(%Args{username: "fred"}, fn -> ["secret", "http://someserver"] end)

    config = Configurations.get()

    assert Base.encode64("fred:secret") == config.base64_encoded
    assert "http://someserver" == config.jira_server
  end
end

