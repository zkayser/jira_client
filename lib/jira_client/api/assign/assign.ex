defmodule JiraClient.Api.Assign do
  # curl --request PUT \
  # --url '/rest/api/2/issue/{issueIdOrKey}/assignee' \
  # --header 'Authorization: Bearer <access_token>' \
  # --header 'Accept: application/json' \
  # --header 'Content-Type: application/json' \
  # --data '{
  # "accountId": "384093:32b4d9w0-f6a5-3535-11a3-9c8c88d10192"
  # }'

  @request Application.get_env(:jira_client, :request_module, JiraClient.Http.Request)

  @behaviour JiraClient.Api.Sender

  def send(attributes, _, logging \\ false) do
    body = """
    {
        "accountId": "#{attributes.account_id}"
    }
    """

    response = @request.new(:put, body, "/rest/api/2/issue/#{attributes.issue_id}/assignee")
    |> @request.send(logging)

    {:ok, response}
  end
end
