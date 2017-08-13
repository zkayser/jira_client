defmodule JiraClient.Command.CreateIssue do
  @moduledoc """
    Creates a JIRA issue related to a project, with a speciric fixVersion.
  """

  alias JiraClient.Api.CreateIssue, as: ApiCreateIssue
  alias JiraClient.Api.CreateIssueRequest, as: ApiCreateIssueRequest
  alias JiraClient.Api.CreateIssueResponse, as: ApiCreateIssueResponse

  @behaviour JiraClient.Command

  def run(args) do
    with request         <- ApiCreateIssueRequest.format(args),
         {:ok, response} <- ApiCreateIssue.send(request),
         {:ok, parsed}   <- ApiCreateIssueResponse.parse(response)
    do
      {:ok, "Created #{parsed.issue_id}"}
    else
      error -> error
    end

  end
end


