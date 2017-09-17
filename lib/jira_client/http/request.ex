defimpl String.Chars, for: JiraClient.Http.Request do
  def to_string(request) do
    method = request.http_method |> Kernel.to_string |> String.upcase

    ~s(
    #{method} #{request.path}
    #{header(request, "Content-Type")}
    #{header(request, "Authorization")}

    #{request.body}
    )
  end

  defp header(request, name) do
    "#{name}: #{request.headers[String.to_atom(name)]}"
  end
end

defmodule JiraClient.Http.Request do
  alias JiraClient.Http.Request
  alias JiraClient.Auth.Credentials

  defstruct headers: [],
            body: %{},
            path: "",
            base_url: "",
            http_method: :get

  def new(method, body, path, creds_get_fn \\ fn -> Credentials.get() end) do
    # TODO remove this encode call in preference of an api with a consistent string in string out protocol.
    {:ok, body} = Poison.encode(body)
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
    HTTPotion.request(method, url(req), [headers: headers])
    |> logging
  end

  def send(%Request{headers: headers, body: body, http_method: method} = req) do
    IO.inspect headers
    HTTPotion.request(method, url(req), [body: body, headers: headers])
    |> logging
  end

  defp logging(response) do
    IO.inspect response
    response
  end
end



