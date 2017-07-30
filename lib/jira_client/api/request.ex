defmodule JiraClient.Api.Request do
  alias JiraClient.Api.Request
  alias JiraClient.Auth.Credentials

  defstruct headers: [],
            body: %{},
            path: "",
            base_url: "",
            http_method: :get

  def new(method \\ :get, body, path) do
    {:ok, body} = Poison.encode(body)
    %Request{
      headers: ["Content-Type": "application/json", "Authorization": "Basic #{Credentials.get()}"],
      body: body,
      path: path,
      base_url: Application.get_env(:jira_client, :base_url),
      http_method: method
    }
  end

  def url(%Request{base_url: base, path: path}) do
    "#{base}/#{path}"
  end

  def send(%Request{headers: headers, body: "{}", http_method: method} = req) do
    HTTPotion.request(method, url(req), [headers: headers]) 
  end

  def send(%Request{headers: headers, body: body, http_method: method} = req) do
    HTTPotion.request(method, url(req), [body: body, headers: headers])
  end
end
