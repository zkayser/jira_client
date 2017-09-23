defmodule HTTPotion.Response.String.CharsTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  #     (stdlib) :io.put_chars(:standard_io, :unicode, 
          #[["Content-Type": "application/json", Authorization: "Basic ZWR3YXJkLnN1bWVyZmllbGRAcGx4aXMuY29tOnU3IzhuMzRB"], 10]
        #)

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
    assert Regex.match?(~r/"expand":"description/, output) , "No match: '#{output}'"
  end
 

end

