defmodule JiraClient.Command.Assign do
  @moduledoc """
    An assign command assigns an issue to a user. If the user is not specified then the
    username of the logged in user is assumed as the assign to me feature.

    Documentation:

    Find the user: https://developer.atlassian.com/cloud/jira/platform/rest/v3/#api-rest-api-3-user-search-get

    curl --request GET \
      --url '/rest/api/3/user/search' \
      --header 'Authorization: Bearer <access_token>' \
      --header 'Accept: application/json'

    Assign the user: https://developer.atlassian.com/cloud/jira/platform/rest/v3/#api-rest-api-3-issue-issueIdOrKey-assignee-put

    curl --request PUT \
      --url '/rest/api/3/issue/{issueIdOrKey}/assignee' \
      --header 'Authorization: Bearer <access_token>' \
      --header 'Accept: application/json' \
      --header 'Content-Type: application/json' \
      --data '{
      "accountId": "384093:32b4d9w0-f6a5-3535-11a3-9c8c88d10192"
    }'
  """

  alias JiraClient.Api.GetUser,         as: ApiGetUser
  alias JiraClient.Api.GetUserParser,   as: ApiGetUserParser

  alias JiraClient.Api.Assign,          as: ApiAssign
  alias JiraClient.Api.AssignParser,    as: ApiAssignParser

  @behaviour JiraClient.Command

  def run(args) do
    with  {:ok, user}   <- get_user(args.username, args.logging),
          {:ok, result} <- assign_issue(user.account_id, args.issue_id, args.logging)
    do
      {:ok, "#{inspect result}"}
    else
      message -> message
    end
  end

  defp get_user(username, logging) do
    with {:ok, response} <- ApiGetUser.send(%{username: username}, "", logging),
         {:ok, user }    <- ApiGetUserParser.parse(response)
    do
      {:ok, user}
    else
      message -> {:error, message}
    end
  end

  defp assign_issue(account_id, issue_id, logging) do
    with {:ok, response} <- ApiAssign.send(%{account_id: account_id, issue_id: issue_id}, "", logging),
         {:ok, _result}  <- ApiAssignParser.parse(response)
    do
      {:ok, "Assigned"}
    else
      {:error, message} -> {:error, message}
    end
  end
end

