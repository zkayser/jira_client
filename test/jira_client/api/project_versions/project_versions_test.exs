defmodule JiraClient.Api.ProjectVersionsTest do
  use ExUnit.Case
  doctest JiraClient.Api.ProjectVersions

  alias JiraClient.Api.ProjectVersions
  alias JiraClient.Http.RequestFake

  setup do
    RequestFake.init()
  end

  test "send request" do
    RequestFake.expect_response(~s(echo some request))

    {:ok, response} = ProjectVersions.send(%{project_id: "XXX"}, "some request")

    assert {:get, "", "rest/api/latest/project/XXX/versions"} == RequestFake.next_request()
    assert "echo some request" == response
  end
end
