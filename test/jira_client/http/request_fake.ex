defmodule JiraClient.Http.RequestFake do
  alias JiraClient.Http.Request

  def init() do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
    :ok
  end

  def expect_response(response) do
      Agent.update(__MODULE__, fn state -> Map.put(state, :response, response) end)
  end

  def new(method, body, path, creds_get_fn \\ fn -> "username:password" end) do
    %Request{
      headers: ["Content-Type": "application/json", "Authorization": "Basic #{creds_get_fn.()}"],
      body: body,
      path: path,
      base_url: Application.get_env(:jira_client, :base_url),
      http_method: method
    }
  end

  def send(_) do
    response = Agent.get(__MODULE__, fn state -> state.response end)
    {:ok, response}
  end
end
