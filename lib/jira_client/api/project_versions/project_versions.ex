defmodule JiraClient.Api.ProjectVersions do
  @moduledoc """
    Send the formatted project versions command to the JIRA server and return the json response.
  """

  @request Application.get_env(:jira_client, :request_module, JiraClient.Http.Request)

  @behaviour JiraClient.Api.Sender

  # GET /rest/api/2/project/{projectIdOrKey}/versions
  # input:
  #   attributes.project_id: String.t
  #
  def send(attributes, _, logging \\ false) do
    response = @request.new(:get, "", "rest/api/latest/project/#{attributes.project_id}/versions")
    |> @request.send(logging)

    {:ok, response}
  end
end
