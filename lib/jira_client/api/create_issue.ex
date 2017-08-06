defmodule JiraClient.Api.CreateIssue do
  @moduledoc """
    Send the formatted create issue command to the JIRA server and return the json response.
  """

  def send(request) do
    JiraClient.Http.Request.new(:post, request, "rest/api/2/issue", fn -> Base.encode64("username:password") end)
    |> JiraClient.Http.Request.send
  end
end
