defmodule JiraClientTest do
  use ExUnit.Case
  doctest JiraClient

  import ExUnit.CaptureIO

  # TODO using the config to inject alternate modules feels like a heavy solution. I would like to see a test specified solution.
  defmodule CommandFake.CreateIssue do
    def run(args) do
      IO.puts("Fake CreateIssue: #{inspect args}")
      {:ok, inspect args}
    end
  end

  test "call main_client with valid argument" do
    output = capture_io(fn ->
      exit_code = JiraClient.main_client(["create_issue", "--project", "PROJECT A", "--fixVersion", "1.2.3", "--message", "MESSAGE A"])

      assert 0 == exit_code
    end)

    assert Regex.match?(~r/Fake CreateIssue/, output), "Output doesn't match expected text: '#{output}'"
  end

  test "call main_client with bad arguments" do
    output = capture_io(fn ->
      exit_code = JiraClient.main_client(["invalid"])

      assert 1 == exit_code
    end)

    assert Regex.match?(~r/WARN: invalid command: 'invalid'/, output), "Output doesn't match expected text: '#{output}'"
  end

end
