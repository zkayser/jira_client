defmodule JiraClient.Command.CloseIssue do

  @spec run(JiraClient.Args.t) :: {Atom.t, String.t}
  def run(args) do

    {:ok, inspect args}
  end
end
