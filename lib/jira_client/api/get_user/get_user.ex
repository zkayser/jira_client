defmodule JiraClient.Api.GetUser do
  # curl --request GET \
  # --url '/rest/api/2/user' \
  # --header 'Authorization: Bearer <access_token>' \
  # --header 'Accept: application/json'

  @request Application.get_env(:jira_client, :request_module, JiraClient.Http.Request)

  @behaviour JiraClient.Api.Sender

  def send(attributes, _, logging \\ false) do
    response = @request.new(:get, "", "/rest/api/2/user")
    |> @request.send(logging)

    {:ok, response}
  end
end
