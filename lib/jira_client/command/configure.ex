defmodule JiraClient.Command.Configure do
  @moduledoc """
    Allow a user to create a configuration file for using this product.
  """

  alias JiraClient.Auth.Credentials

  @behaviour JiraClient.Command

  def run(args) do
    Credentials.init(args.username, args.password)
    {:ok, "Configuration complete"}
  end
end
