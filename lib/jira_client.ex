defmodule JiraClient do
  alias JiraClient.Args

  # TODO can we use Application.get_application(__MODULE__) to eliminate app name duplication
  @command_module Application.get_env(:jira_client, :command_module, JiraClient.Command)

  def main(args) do
    args
    |> main_client
    |> System.stop
  end

  def main_client(args) do
    IO.puts("Welcome to Jira Client")

    case run Args.parse(args) do
      {:ok, message} -> 
        IO.puts message
        0
      {:error, message} -> 
        IO.puts "ERROR (known): #{message}"
        1
      message ->
        IO.puts "ERROR (unknown): #{inspect message}"
        2
    end
  end

  defp run({:ok, args}) do
    JiraClient.Command.run(@command_module, args.command, args)
  end

  defp run({:error, args}) do
    {:error, "#{args}"}
  end
end

