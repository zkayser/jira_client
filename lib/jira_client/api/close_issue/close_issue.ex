defmodule JiraClient.Api.CloseIssue do
  
  @moduledoc """
  Send the formatted close_issue request to the Jira server and return the JSON response
  """

  @request Application.get_env(:jira_client, :request_module, JiraClient.Http.Request)

  @behaviour JiraClient.Api.Sender

  def send(attributes, body) do
    @request.new(:post, body, "/rest/api/latest/issue/#{attributes.id}/transitions")
    |> @request.send()
  end
end
