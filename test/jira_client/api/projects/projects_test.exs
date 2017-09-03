defmodule JiraClient.Api.ProjectsTest do
  use ExUnit.Case

  alias JiraClient.Api.Projects
  alias JiraClient.Http.RequestFake

  setup do
    RequestFake.init()
  end

  test "send request" do
    RequestFake.expect_response(~s(echo some request))

    {:ok, response} = Projects.send("some request")

    assert "echo some request" == response
  end
end
