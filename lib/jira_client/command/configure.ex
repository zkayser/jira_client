defmodule JiraClient.Command.Configure do

  alias JiraClient.Auth.Credentials

  @behaviour JiraClient.Command

  def run(args) do
    Credentials.init(args.username, args.password)
    {:ok, "Configuration complete"}
  end
end
