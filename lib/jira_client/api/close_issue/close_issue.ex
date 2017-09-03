defmodule JiraClient.Api.CloseIssue do
  
  @moduledoc """
  Send the formatted close_issue request to the Jira server and return the JSON response
  """

  @request Application.get_env(:jira_client, :request_module, JiraClient.Http.Request)

  @behaviour JiraClient.Api.Sender

  def send(request) do
    @request.new(:post, request, "/rest/api/latest/issue/#{request.id}/transitions")
    |> @request.send()
  end
end
