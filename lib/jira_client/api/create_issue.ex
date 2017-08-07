defmodule JiraClient.Api.CreateIssue do
  @moduledoc """
    Send the formatted create issue command to the JIRA server and return the json response.
  """

  def send(request) do
    JiraClient.Http.Request.new(:post, request, "rest/api/2/issue")
    |> JiraClient.Http.Request.send
  end
end
