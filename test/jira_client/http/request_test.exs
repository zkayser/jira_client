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

    assert Regex.match?(~r/REQUEST:/, output)                                      , "No match: '#{output}'"
    assert Regex.match?(~r/GET http:\/\/a\/b/, output)                             , "No match: '#{output}'"
    assert Regex.match?(~r/Content-Type: application\/json/, output)               , "No match: '#{output}'"
    assert Regex.match?(~r/Authorization: Basic dXNlcm5hbWU6cGFzc3dvcmQ=/, output) , "No match: '#{output}'"
    assert Regex.match?(~r/REQUEST BODY/, output)                                  , "No match: '#{output}'"
  end

  test "output pretty response" do
    response = %HTTPotion.Response{
      body: "[{\"expand\":\"description,lead,issueTypes,url,projectKeys\" ...",
      headers: %HTTPotion.Headers{
        hdrs: %{
          "atl-vtm-backend-time" => "797",
          "atl-vtm-queue-time" => "0",
          "atl-vtm-time" => "835",
          "cache-control" => "no-cache, no-store, no-transform",
          "connection" => "keep-alive",
          "content-type" => "application/json;charset=UTF-8",
          "date" => "Sun, 17 Sep 2017 19:48:04 GMT",
          "server" => "Atlassian Proxy/0.1.114",
          "set-cookie" => "atlassian.xsrf.token=BXB6-PXNC-GYTW-Q8T7|02bed39038b5aa62e2cc35421ceff969de71aa11|lin; Path=/; Secure",
          "strict-transport-security" => "max-age=315360000; includeSubDomains; preload",
          "transfer-encoding" => "chunked",
          "vary" => "Accept-Encoding",
          "x-arequestid" => "1188x2113526x5",
          "x-ausername" => "esumerfield",
          "x-content-type-options" => "nosniff",
          "x-seraph-loginreason" => "OK"
        }
      },
      status_code: 200
    }

    output = capture_io fn ->
      IO.puts(response)
    end

    assert Regex.match?(~r/RESPONSE:/, output)                                     , "No match: '#{output}'"
    assert Regex.match?(~r/HTTP\/1.1 200 OK/, output)                              , "No match: '#{output}'"
    assert Regex.match?(~r/Date: Sun, 17 Sep 2017 19:48:04 GMT/, output)           , "No match: '#{output}'"
    assert Regex.match?(~r/Connection: keep-alive/, output)                        , "No match: '#{output}'"
    assert Regex.match?(~r/Server: Atlassian Proxy\/0.1.114/, output)              , "No match: '#{output}'"
    assert Regex.match?(~r/Content-Type: application\/json;charset=UTF-8/, output) , "No match: '#{output}'"
    
  end
  
  
end
