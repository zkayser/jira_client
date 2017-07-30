defmodule JiraClient.Auth.CredentialsTest do
  use ExUnit.Case, async: true
  alias JiraClient.Auth.Credentials
  alias JiraClient.FileUtils
  import ExUnit.CaptureIO

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
    test "returns encoded credentials when credentials file exists" do
      assert Credentials.get(test_file()) == Base.encode64("username:password")
    end

    test "prompts for username and password when credentials file does not exist" do
      FileUtils.delete_creds_file()

      assert capture_io(fn ->
          Credentials.get()
        end) == "Please provide your username and password.\nUsername:Password:"
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
