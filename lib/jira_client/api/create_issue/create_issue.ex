defmodule JiraClient.Api.CreateIssue do
  @moduledoc """
    Send the formatted create issue command to the JIRA server and return the json response.
  """

  @request Application.get_env(:jira_client, :request_module, JiraClient.Http.Request)

  @behaviour JiraClient.Api.Sender

  def send(_, body) do
    response = @request.new(:post, body, "rest/api/latest/issue")
    |> @request.send

    {:ok, response}
  end
end
