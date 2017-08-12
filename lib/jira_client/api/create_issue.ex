defmodule JiraClient.Api.CreateIssue do
  @moduledoc """
    Send the formatted create issue command to the JIRA server and return the json response.
  """

  @request Application.get_env(:jira_client, :request_module, JiraClient.Http.Request)

  def send(request) do
    @request.new(:post, request, "rest/api/2/issue")
    |> @request.send
  end
end
