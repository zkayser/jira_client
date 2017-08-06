defmodule JiraClient.Http.RequestTest do
  use ExUnit.Case
  alias JiraClient.Http.Request

  @example_body %{field: :value, field2: %{key: :value2}}
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
    assert req.base_url == System.get_env("JIRA_BASE_URL")
  end

  test "request url", context do
    req = Request.new(:get, @example_body, @path, context[:creds_get_fn])
    assert Request.url(req) == "#{System.get_env("JIRA_BASE_URL")}/#{@path}"
  end
end
