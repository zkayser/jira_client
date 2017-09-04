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
end

