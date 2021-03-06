defmodule JiraClient.Api.CreateIssue do
  @moduledoc """
    Send the formatted create issue command to the JIRA server and return the json response.
  """

  @request Application.get_env(:jira_client, :request_module, JiraClient.Http.Request)

  @behaviour JiraClient.Api.Sender

  def send(_, body, logging \\ false) do
    response = @request.new(:post, body, "rest/api/latest/issue")
    |> @request.send(logging)

    {:ok, response}
  end
end
