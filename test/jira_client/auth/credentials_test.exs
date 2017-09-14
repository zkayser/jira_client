defmodule JiraClient.Auth.CredentialsTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias JiraClient.Auth.Credentials
  alias JiraClient.Utils.FileMock

  setup do
    FileMock.start_link
    :ok
  end

  test "get credentials when there are none" do
    output = capture_io fn -> Credentials.get() end

    assert Regex.match?(~r/Your credentials have not been configured/, output), "Output doesn't match expected text: '#{output}'"
  end

  test "get credentials when they exist" do
    Credentials.store(%JiraClient.Credentials{base64_encoded: "username:password"})

    assert "username:password" == Credentials.get() 
  end

  test "init with no credentials" do
    assert %JiraClient.Credentials{errors: ["Credentials not provided"]} == Credentials.init()
  end

  test "init with an error passed in" do
    assert %JiraClient.Credentials{errors: ["Credentials not provided"]} == Credentials.init(:any, {:error, "message"})
  end

  test "init with empty strings" do
    assert %JiraClient.Credentials{errors: ["Credentials not provided"]} == Credentials.init("", "")
  end
  
  test "init with good username and password" do
    assert %JiraClient.Credentials{base64_encoded: "dXNlcm5hbWU6cGFzc3dvcmQ="} == Credentials.init("username", "password")
  end
  
end

