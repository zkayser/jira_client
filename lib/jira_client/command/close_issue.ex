defmodule JiraClient.Command.CloseIssue do
  @moduledoc """
    A close operation on a JIRA issue is really a workflow transition that
    results in the issue being in the Closed state. Different projects can
    define different Events that reult in an issue being closed making it
    difficult to implement a standard close operation.

    For this implementation a "Close" Event will be used and any JIRA project
    wishing to be managed by this client must implement that Event.

    Documentation: https://developer.atlassian.com/cloud/jira/platform/rest/#api-api-2-issue-issueIdOrKey-transitions-post
  """

  alias JiraClient.Api.GetTransitions,      as: ApiGetTransitions
  alias JiraClient.Api.GetTransitionsParser,as: ApiGetTransitionsParser
  alias JiraClient.Api.CloseIssue,          as: ApiCloseIssue
  alias JiraClient.Api.CloseIssueFormatter, as: ApiCloseIssueFormatter
  alias JiraClient.Api.CloseIssueParser,    as: ApiCloseIssueParser

  @behaviour JiraClient.Command

  def run(args) do
    with {:ok, transition} <- find_transition(args.issue, args.logging),
         {:ok, result}     <- close_issue(args.issue, transition.id, args.logging)
    do
      {:ok, "#{inspect result}"}
    else
      message -> message
    end
  end

  defp find_transition(issue_name, logging) do
    with {:ok, response}    <- ApiGetTransitions.send(%{issue: issue_name}, "", logging),
         {:ok, transitions} <- ApiGetTransitionsParser.parse(response) ,
         {:ok, transition}  <- select_transition("Done", transitions)
    do
      {:ok, transition}
    else
      message -> {:error, message}
    end
  end

  defp select_transition(transition_name, transitions) do
    case Enum.find(transitions, &(transition_name == &1.name)) do
      nil        -> {:error, "No transition called '#{transition_name}'"}
      transition -> {:ok, transition}
    end
  end

  defp close_issue(issue_id, transition_id, logging) do
    with {:ok, request}  <- ApiCloseIssueFormatter.format(%{transition_id: transition_id}),
         {:ok, response} <- ApiCloseIssue.send(%{issue_id: issue_id}, request, logging),
         {:ok, _result}  <- ApiCloseIssueParser.parse(response)
    do
      {:ok, 'Clossed'}
    else
      message -> {:error, message}
    end
  end
end

