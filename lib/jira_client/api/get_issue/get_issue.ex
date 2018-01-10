defmodule JiraClient.Api.GetIssue do
  # GET /rest/api/2/issue/{issueIdOrKey}

  @request Application.get_env(:jira_client, :request_module, JiraClient.Http.Request)

  @behaviour JiraClient.Api.Sender

  def send(attributes, _, logging \\ false) do
    response = @request.new(:get, "", "/rest/api/2/issue/#{attributes.issue}")
    |> @request.send(logging)

    {:ok, response}
  end
end
