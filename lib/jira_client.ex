defmodule JiraClient do
  alias JiraClient.Args

  @command_module Application.get_env(:jira_client, :command_module, JiraClient.Command)

  def main(args) do
    IO.puts("Welcome to Jira Client")

    run Args.parse(args)
  end

  defp run({:ok, args}) do
    JiraClient.Command.run(@command_module, args.command, args)
  end

  defp run({:error, args}) do
    IO.puts("ERROR: #{args}")
  end
end
