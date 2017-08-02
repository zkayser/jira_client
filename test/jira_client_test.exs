defmodule JiraClientTest do
  use ExUnit.Case
  doctest JiraClient

  import ExUnit.CaptureIO

  defmodule CommandFake.CreateIssue do
    def run(args) do
      IO.puts("Fake CreateIssue: #{inspect args}")
    end
  end

  test "call main with valid argument" do
    output = capture_io(fn ->
      JiraClient.main(["create_issue", "--project", "PROJECT A", "--fixVersion", "1.2.3", "--message", "MESSAGE A"])
    end)

    assert Regex.match?(~r/Fake CreateIssue/, output), "Output doesn't match expected text: '#{output}'"
  end

  test "call main with bad arguments" do
    output = capture_io(fn ->
      JiraClient.main(["invalid"])
    end)

    assert Regex.match?(~r/Welcome to Jira Client/, output), "Output doesn't match expected text: '#{output}'"
    assert Regex.match?(~r/ERROR: invalid command: 'invalid'/, output), "Output doesn't match expected text: '#{output}'"
  end

end
