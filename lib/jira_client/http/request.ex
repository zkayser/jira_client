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

  def send(%Request{headers: headers, body: {}, http_method: method} = request, logging) do
    logging(request, logging)
    response = HTTPotion.request(method, url(request), [headers: headers])
    logging(response, logging)
  end

  def send(%Request{headers: headers, body: body, http_method: method} = request, logging) do
    logging(request, logging)
    response = HTTPotion.request(method, url(request), [body: body, headers: headers])
    logging(response, logging)
  end

  def logging(message, false), do: message
  def logging(message, true) do
    IO.puts message
    message
  end
end



