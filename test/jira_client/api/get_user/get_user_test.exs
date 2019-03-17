defmodule JiraClient.Api.GetUserTest do
  use ExUnit.Case

  alias JiraClient.Api.GetUser
  alias JiraClient.Http.RequestFake

  setup do
    RequestFake.init()
  end

  test "send request" do
    RequestFake.expect_response(%HTTPotion.Response{body: ~s({"accountId":"some-long-guid"})})

    {:ok, response} = GetUser.send(%{}, "")

    assert {:get, "", "/rest/api/2/user"} == RequestFake.next_request()
    assert response.body =~ "some-long-guid"
  end
 
end

