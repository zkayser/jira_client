defmodule JiraClient.Auth.ConfigurationsMockTest do
  use ExUnit.Case, async: true

  @credentials Application.get_env(:jira_client, :credentials_module)
  @user_creds "username:api_token"

  describe "init" do
    test "credentials with username and api_token" do
      {username, api_token} = {"username", "secret_api_token"}
      assert @credentials.init(username, api_token).base64_encoded == Base.encode64("#{username}:#{api_token}")
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
      assert @credentials.get().base64_encoded == Base.encode64(@user_creds)
    end

    test "prompts for username and api_token when credentials file does not exist" do
      Application.delete_env(:jira_client, :test_creds)
      assert @credentials.get().base64_encoded == Base.encode64(@user_creds)
    end
  end
end

