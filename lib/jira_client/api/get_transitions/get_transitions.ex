defmodule JiraClient.Api.GetTransitions do
  @moduledoc """
  Send the formatted get transitions request to the Jira server and return the JSON response
  """

  @request Application.get_env(:jira_client, :request_module, JiraClient.Http.Request)

  @behaviour JiraClient.Api.Sender

  def send(attributes, _body, logging \\ false) do
    response = @request.new(:get, "", "/rest/api/2/issue/#{attributes.issue}/transitions")
    |> @request.send(logging)

    {:ok, response}
  end

end
