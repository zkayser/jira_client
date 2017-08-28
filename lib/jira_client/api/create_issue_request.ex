defmodule JiraClient.Api.CreateIssueRequest do
  @moduledoc """
    Documentation: https://developer.atlassian.com/jiradev/jira-apis/jira-rest-apis/jira-rest-api-tutorials/jira-rest-api-example-create-issue
  """

  @behaviour JiraClient.Api.Request

  def format(request) do
    Poison.encode(%{
      fields: %{
        project: %{
          key: request.project_id
        },
        summary: request.message,
        fixVersions: [
          %{
            id: request.fix_version
          }
        ],
        issuetype: %{
          name: "Task"
        }
      }
    })
  end

end

