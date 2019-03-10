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

  #alias JiraClient.Api.Assign,          as: ApiAssign
  #alias JiraClient.Api.AssignFormatter, as: ApiAssignFormatter
  #alias JiraClient.Api.AssignParser,    as: ApiAssignParser

  #@behaviour JiraClient.Command

  #def run(args) do
    #with {:ok, result}     <- assign_issue(args.issue, args.logging)
    #do
      #{:ok, "#{inspect result}"}
    #else
      #message -> message
    #end
  #end

  #defp assign_issue(issue_id, logging) do
    #with {:ok, request}  <- ApiAssignFormatter.format(%{issue_id: issue_id}),
         #{:ok, response} <- ApiAssign.send(%{account_id: account_id}, request, logging),
         #{:ok, _result}  <- ApiAssignParser.parse(response)
    #do
      #{:ok, "Assigned"}
    #else
      #message -> {:error, message}
    #end
  #end
end

