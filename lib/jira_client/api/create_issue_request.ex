defmodule JiraClient.Api.CreateIssueRequest do
  @moduledoc """
    Documentation: https://developer.atlassian.com/jiradev/jira-apis/jira-rest-apis/jira-rest-api-tutorials/jira-rest-api-example-create-issue

    {
      "fields": {
         "project":
         {
            "key": "ABC-123"
         },
         "summary": "REST ye merry gentlemen.",
         "description": "Creating of an issue using project keys and issue type names using the REST API",
         "issuetype": {
            "name": "Task"
         }
       }
    }
  """

  @behaviour JiraClient.Api.Request

  def format(request) do
    Poison.encode(%{
      fields: %{
        project: %{
          key: request.project
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

