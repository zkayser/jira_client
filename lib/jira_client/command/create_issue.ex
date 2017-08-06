defmodule JiraClient.Command.CreateIssue do
  @moduledoc """
    Creates a JIRA issue related to a project, with a speciric fixVersion.
  """

  alias JiraClient.Api.CreateIssue, as: ApiCreateIssue
  alias JiraClient.Api.CreateIssueRequest, as: ApiCreateIssueRequest
  alias JiraClient.Api.CreateIssueResponse, as: ApiCreateIssueResponse

  @behaviour JiraClient.Command

  def run(args) do
    args
    |> ApiCreateIssueRequest.format
    |> ApiCreateIssue.send
    |> ApiCreateIssueResponse.parse
  end
end


