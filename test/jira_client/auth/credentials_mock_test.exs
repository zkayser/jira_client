defmodule JiraClient.Auth.CredentialsMockTest do
  use ExUnit.Case, async: true

  @credentials Application.get_env(:jira_client, :credentials_module)
  @user_creds "username:password"

  describe "init" do
    test "credentials with username and password" do
      {username, password} = {"username", "secretpassword"}
      assert @credentials.init(username, password).base64_encoded == Base.encode64("#{username}:#{password}")
    end

    test "blank credentials" do
      assert @credentials.init().errors == ["Credentials not provided"]
    end

    test "empty strings" do
      assert @credentials.init("", "").errors == ["Credentials not provided"]
    end
  end

  describe "get" do
    test "returns encoded credentials when credentials exist" do
      Application.put_env(:jira_client, :test_creds, Base.encode64(@user_creds))
      assert @credentials.get("fake/file/path").base64_encoded == Base.encode64(@user_creds)
    end

    test "prompts for username and password when credentials file does not exist" do
      Application.delete_env(:jira_client, :test_creds)
      assert @credentials.get("fake/file/path").base64_encoded == Base.encode64(@user_creds)
    end
  end
end
