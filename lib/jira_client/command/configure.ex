defmodule JiraClient.Command.Configure do
  @moduledoc """
    Allow a user to create a configuration file for using this product.
  """

  alias JiraClient.Auth.Credentials

  @behaviour JiraClient.Command

  def run(args) do
    run_with_password(args, fn -> 
      IO.puts("Enter JIRA password: ")
      :io.get_password()
    end)
  end

  def run_with_password(args, password_getter) do
    password = password_getter.()

    Credentials.init(args.username, password)
    {:ok, "Configuration complete"}
  end
end
