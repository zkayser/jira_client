defmodule JiraClient.Command.Configure do

  alias JiraClient.Auth.Credentials

  @spec run(JiraClient.Args.t) :: {Atom.t, String.t}
  def run(args) do
    Credentials.init(args.username, args.password)
    {:ok, "Configuration complete"}
  end
end
