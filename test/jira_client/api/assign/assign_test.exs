defmodule JiraClient.Api.AssignTest do
  use ExUnit.Case

  alias JiraClient.Api.Assign
  alias JiraClient.Http.RequestFake

  setup do
    RequestFake.init()
  end

  test "send request" do
    RequestFake.expect_response(%HTTPotion.Response{body: ""})

    expected_body = """
    {
        "accountId": "some-long-guid"
    }
    """

    {:ok, response} = Assign.send(%{account_id: "some-long-guid", issue_id: "XXX-123"}, "")

    assert {:put, expected_body, "/rest/api/2/issue/XXX-123/assignee", %{}} == RequestFake.next_request()

    assert response.body =~ ""
  end
 
end

