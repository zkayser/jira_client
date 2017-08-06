defmodule JiraClient.Api.CreateIssueRequest do
  @moduledoc """
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
    inspect request
  end

end

