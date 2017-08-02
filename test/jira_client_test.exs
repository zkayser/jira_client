defmodule JiraClientTest do
  use ExUnit.Case
  doctest JiraClient

  import ExUnit.CaptureIO

  test "call main" do
    output = capture_io(fn ->
      JiraClient.main(["invalid"])
    end)

    assert Regex.match?(~r/Welcome to Jira Client:.*/, output), "Output doesn't match expected text: #{output}"
  end
end
