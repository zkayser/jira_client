defmodule JiraClient.Command.AssignTest do
  use ExUnit.Case
  doctest JiraClient.Command.Assign

  alias JiraClient.Args
  alias JiraClient.Http.RequestFake

  setup do
    RequestFake.init()
  end

  describe "success" do
    test "assign" do
      RequestFake.expect_response(%HTTPotion.Response{body: ~s({
          "accountId": "123"
        }
      )})

      RequestFake.expect_response(%HTTPotion.Response{body: ~s({
          something: 1
        }
      ),
      status_code: 204})

      {:ok, args} = Args.parse(["user", "--username", "someuser", "--issue", "XXX-123"])
      {:ok, message} = JiraClient.Command.Assign.run(args)

      assert message
    end
  end
end
