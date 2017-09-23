defmodule JiraClient.Http.Request do
  alias JiraClient.Http.Request
  alias JiraClient.Auth.Credentials

  defstruct headers: [],
            body: %{},
            path: "",
            base_url: "",
            http_method: :get

  def new(method, body, path, creds_get_fn \\ fn -> Credentials.get() end) do
    %Request{
      headers: ["Content-Type": "application/json", "Authorization": "Basic #{creds_get_fn.()}"],
      body: body,
      path: path,
      base_url: Application.get_env(:jira_client, :base_url),
      http_method: method
    }
  end

  def url(%Request{base_url: base, path: path}) do
    "#{base}/#{path}"
  end

  def send(%Request{headers: headers, body: {}, http_method: method} = req) do
    logging(req)
    HTTPotion.request(method, url(req), [headers: headers])
    |> logging
  end

  def send(%Request{headers: headers, body: body, http_method: method} = req) do
    logging(req)
    HTTPotion.request(method, url(req), [body: body, headers: headers])
    |> logging
  end

  defp logging(message) do
    IO.puts message
    message
  end
end



