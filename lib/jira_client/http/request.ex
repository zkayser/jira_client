defmodule JiraClient.Http.Request do
  alias JiraClient.Http.Request
  alias JiraClient.Auth.Configurations

  defstruct headers: [],
            body: %{},
            path: "",
            queryString: %{},
            base_url: "",
            http_method: :get

  def new(method, body, path, config_get_fn \\ fn -> Configurations.get() end) do
    config = config_get_fn.()
    basic_auth = config.base64_encoded
    base_url = config.jira_server

    %Request{
      headers: ["Content-Type": "application/json", "Authorization": "Basic #{basic_auth}"],
      body: body,
      path: path,
      base_url: base_url,
      http_method: method
    }
  end

  def queryString(request, queryString) do
    %{request | queryString: queryString}
  end

  def url(%Request{base_url: base_url, path: path}) do
    "#{base_url}/#{path}"
  end

  def send(%Request{headers: headers, body: {}, http_method: method} = request, logging) do
    logging(request, logging)
    response = HTTPotion.request(method, url(request), [headers: headers])
    logging(response, logging)
  end

  def send(%Request{headers: headers, body: body, queryString: queryString, http_method: method} = request, logging) do
    logging(request, logging)
    response = HTTPotion.request(method, url(request), [body: body, query: queryString, headers: headers])
    logging(response, logging)
  end

  def logging(message, false), do: message
  def logging(message, true) do
    IO.inspect message
    message
  end
end
