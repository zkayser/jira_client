defmodule JiraClient.CommandTest do
  use ExUnit.Case
  doctest JiraClient.Command

  defmodule DoSomething do
    def run(args) do
      case args do
        [] -> "no args"
        _  -> hd(args)
      end
    end
  end

  describe "good commands" do

    test "Run a command with no arguments" do
      {:ok, result} = JiraClient.Command.run(__MODULE__, "do_something")

      assert result == "no args"
    end

    test "Run a command" do
      {:ok, result} = JiraClient.Command.run(__MODULE__, "do_something", ["hello world"])

      assert result == "hello world", "Shoudn't be #{inspect result}"
    end
  end

  describe "bad commands" do

    test "invalid module" do
      {:error, message} = JiraClient.Command.run(:"JiraClient.Invalid", "create_issue", [])

      assert "module doesn't exist: JiraClient.Invalid.CreateIssue" == message
    end

    test "invalid comand" do
      {:error, message} = JiraClient.Command.run(__MODULE__, "invalid", [])

      assert "module doesn't exist: #{Atom.to_string(__MODULE__)}.Invalid" == message
    end
  end
end
