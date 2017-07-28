defmodule JiraClient.Auth.CredentialsTest do
  use ExUnit.Case, async: true
  alias JiraClient.Auth.Credentials

  test "credentials with username and password" do
    {username, password} = {"username", "secretpassword"}
    assert Credentials.init(username, password).base64_encoded == Base.encode64("#{username}:#{password}")
  end

  test "blank credentials" do
    assert Credentials.init().errors == ["Credentials not provided"]
  end

  test "empty strings" do
    assert Credentials.init("", "").errors == ["Credentials not provided"]
  end
end
