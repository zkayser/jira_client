defmodule JiraClient.Http.Request.String.CharsTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  setup do
    [creds_get_fn: fn -> Base.encode64("username:password") end]
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


end

