defmodule JiraClient.Http.RequestTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias JiraClient.Http.Request

  @example_body %{field: :value, field2: %{key: :value2}}

  # TODO move definition into Http.Request
  @path "rest/api/2"

  setup do
    [creds_get_fn: fn -> Base.encode64("username:password") end]
  end

  test "Request.new", context do
    req = Request.new(:get, @example_body, @path, context[:creds_get_fn])
    {:ok, body} = Poison.encode(@example_body)
    assert req.http_method == :get
    assert req.path == @path
    assert req.headers == ["Content-Type": "application/json", "Authorization": "Basic #{Base.encode64("username:password")}"]
    assert req.body == body
    assert req.base_url == Application.get_env(:jira_client, :base_url)
  end

  test "request url", context do
    req = Request.new(:get, @example_body, @path, context[:creds_get_fn])
    assert Request.url(req) == "#{Application.get_env(:jira_client, :base_url)}/#{@path}"
  end

  test "output pretty request", context do
    output = capture_io fn ->
      request = JiraClient.Http.Request.new(:get, "REQUEST BODY", "http://a/b", context[:creds_get_fn])
      IO.puts(request)
    end

    assert Regex.match?(~r/GET http:\/\/a\/b/, output)                             , "No match: '#{output}'"
    assert Regex.match?(~r/Content-Type: application\/json/, output)               , "No match: '#{output}'"
    assert Regex.match?(~r/Authorization: Basic dXNlcm5hbWU6cGFzc3dvcmQ=/, output) , "No match: '#{output}'"
    assert Regex.match?(~r/REQUEST BODY/, output)                                  , "No match: '#{output}'"
  end
  
end
