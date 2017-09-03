defmodule JiraClient.Api.Projects do

  @request Application.get_env(:jira_client, :request_module, JiraClient.Http.Request)

  @behaviour JiraClient.Api.Sender

  def send(request) do
    @request.new(:get, request, "rest/api/latest/project")
    |> @request.send
  end
end
