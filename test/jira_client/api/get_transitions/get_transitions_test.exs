defmodule GetTransitionsTest do
  use ExUnit.Case

  alias JiraClient.Api.GetTransitions
  alias JiraClient.Http.RequestFake

  setup do
    RequestFake.init()
  end

  test "send request" do
    RequestFake.expect_response(~s(some response))

    {:ok, _response} = GetTransitions.send(%{issue: "ABC-123"}, "")

    assert {:post, "", "/rest/api/2/issue/ABC-123/transitions"} == RequestFake.next_request()
  end

end

