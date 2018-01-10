defmodule JiraClient do
  alias JiraClient.Args
  alias JiraClient.Command

  @command_module Application.get_env(:jira_client, :command_module, JiraClient.Command)

  def main(args) do
    args
    |> main_client
    |> System.stop
  end

  def main_client(args) do
    case Args.parse(args) |> run do
      {:ok, message} -> 
        IO.puts message
        0
      {:error, message} -> 
        IO.puts "WARN: #{message}"
        1
      message ->
        IO.puts "ERROR: #{inspect message}"
        2
    end
  end

  defp run({:ok, args}) do
    Command.run(@command_module, args.command, args)
  end

  defp run({:error, args}) do
    {:error, "#{args}"}
  end
end

