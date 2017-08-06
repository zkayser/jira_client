defmodule JiraClient.Command.CloseIssue do
  @moduledoc """
    A close operation on a JIRA issue is really a workflow transition that
    results in the issue being in the Closed state. Different projects can
    define different Events that reult in an issue being closed making it
    difficult to implement a standard close operation.

    For this implementation a "Close" Event will be used and any JIRA project
    wishing to be managed by this client must implement that Event.

    Documentation: https://docs.atlassian.com/jira/REST/cloud/#api/2/issue-doTransition
  """

  @spec run(JiraClient.Args.t) :: {Atom.t, String.t}
  def run(args) do

    

    {:ok, inspect args}
  end
end
