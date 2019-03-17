defmodule JiraClient.Http.RequestTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias JiraClient.Http.Request

  @example_body %{field: :value, field2: %{key: :value2}}
  @example_path "rest/api/2"

  setup do
    [config_get_fn: fn -> 
      %JiraClient.Configurations{ base64_encoded: Base.encode64("username:password"), jira_server: "http://someserver" } 
    end]
  end

  test "Request.new", context do
    req = Request.new(:get, @example_body, @example_path, context[:config_get_fn]) |> Request.queryString(%{a: 1, b: 2})

    body = @example_body

    assert req.http_method == :get
    assert req.path == @example_path
    assert req.queryString == %{a: 1, b: 2}
    assert req.headers == ["Content-Type": "application/json", "Authorization": "Basic #{Base.encode64("username:password")}"]
    assert req.body == body
    assert req.base_url == "http://someserver"
  end

  test "request url", context do
    req = Request.new(:get, @example_body, @example_path, context[:config_get_fn])
    assert Request.url(req) == "http://someserver/#{@example_path}"
  end

  test "request url with query string", context do
    req = Request.new(:get, @example_body, @example_path, context[:config_get_fn]) |> Request.queryString(%{a: 1, b: 2})
    assert Request.url(req) == "http://someserver/#{@example_path}"
  end

  test "logging on" do
    assert "\"Hello\"\n" == capture_io fn ->
      assert "Hello" == Request.logging("Hello", true)
    end

  end

  test "logging off" do
    assert "" == capture_io fn ->
      assert "Hello" == Request.logging("Hello", false)
    end
  end
end
