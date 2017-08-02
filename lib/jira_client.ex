defmodule JiraClient do
  alias JiraClient.Args

  def main(args) do
    IO.puts("Welcome to Jira Client: #{args}")

    IO.inspect Args.parse(args)
  end
end
