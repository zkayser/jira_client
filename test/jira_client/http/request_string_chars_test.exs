defmodule JiraClient.Http.Request.String.CharsTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  setup do
    [config_get_fn: fn -> 
      %JiraClient.Configurations{ base64_encoded: Base.encode64("username:api_token"), jira_server: "http://someserver" } 
    end]
  end

  test "output pretty request", context do
    output = capture_io fn ->
      request = JiraClient.Http.Request.new(:get, "REQUEST BODY", "http://a/b", context[:config_get_fn])
      IO.puts(request)
    end

    assert Regex.match?(~r/REQUEST:/, output)                                      , "No match: '#{output}'"
    assert Regex.match?(~r/GET http:\/\/a\/b/, output)                             , "No match: '#{output}'"
    assert Regex.match?(~r/Content-Type: application\/json/, output)               , "No match: '#{output}'"
    assert Regex.match?(~r/REQUEST BODY/, output)                                  , "No match: '#{output}'"
  end

  test "ensure that the Authorization information is not printed", context do
    output = capture_io fn ->
      request = JiraClient.Http.Request.new(:get, "REQUEST BODY", "http://a/b", context[:config_get_fn])
      IO.puts(request)
    end

    assert Regex.match?(~r/Authorization: Basic SECRET/, output), "Should have matched #{output}"
  end

  test "make it clear when thre is no body being posted.", context do
    output = capture_io fn ->
      request = JiraClient.Http.Request.new(:get, "", "http://a/b", context[:config_get_fn])
      IO.puts(request)
    end

    assert Regex.match?(~r/NO BODY/, output) , "Should have indicated that there was no body"
  end

end

