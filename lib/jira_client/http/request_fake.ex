defmodule JiraClient.Http.RequestFake do
  alias JiraClient.Http.Request

  def new(method, body, path, creds_get_fn \\ fn -> "username:password" end) do
    %Request{
      headers: ["Content-Type": "application/json", "Authorization": "Basic #{creds_get_fn.()}"],
      body: body,
      path: path,
      base_url: Application.get_env(:jira_client, :base_url),
      http_method: method
    }
  end

  def send(request) do
    {:ok, "echo #{request.body}"}
  end
end
