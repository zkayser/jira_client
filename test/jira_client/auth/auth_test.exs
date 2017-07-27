defmodule JiraClient.AuthTest do
  use ExUnit.Case, async: true
  alias JiraClient.Auth

  test "set valid authentication method" do
    Auth.set_auth(:oauth)
    assert Application.get_env(:jira_client, :auth_method) == :oauth
  end

  test "set invalid authentication method" do
    current_auth = Application.get_env(:jira_client, :auth_method)
    assert Auth.set_auth(:invalid) == :error
    assert Application.get_env(:jira_client, :auth_method) == current_auth
  end

end
