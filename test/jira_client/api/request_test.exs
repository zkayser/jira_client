defmodule JiraClient.Api.RequestTest do
  use ExUnit.Case, async: true
  alias JiraClient.Api.Request
  alias JiraClient.Auth.Credentials
  @example_body %{field: :value, field2: %{key: :value2}}
  @path "rest/api/2"


  test "Request.new" do
    JiraClient.FileUtils.delete_creds_file()
    JiraClient.FileUtils.write_credentials(Base.encode64("username:password"))

    req = Request.new(@example_body, @path)
    {:ok, body} = Poison.encode(@example_body)
    assert req.http_method == :get
    assert req.path == @path
    assert req.headers == ["Content-Type": "application/json", "Authorization": "Basic #{Credentials.get()}"]
    assert req.body == body
    assert req.base_url == System.get_env("JIRA_BASE_URL")
  end

  test "request url" do
    req = Request.new(@example_body, @path)
    assert Request.url(req) == "#{System.get_env("JIRA_BASE_URL")}/#{@path}"
  end
end
