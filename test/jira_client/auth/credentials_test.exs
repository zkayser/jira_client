defmodule JiraClient.Auth.CredentialsTest do
  use ExUnit.Case, async: true
  alias JiraClient.Auth.Credentials
  alias JiraClient.FileUtils

  describe "init" do
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

  describe "get" do
    test "credentials file exists" do
      assert Credentials.get(test_file()) == Base.encode64("username:password")
    end
  end

  def write_test_file do
    FileUtils.mkdir_for_credentials(:test)
    FileUtils.write_credentials(:test, Base.encode64("username:password"))
  end

  def test_file do
    write_test_file()
    Path.expand("~") |> Path.join(".jira_test/credentials.txt")
  end
end
