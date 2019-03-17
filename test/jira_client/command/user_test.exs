defmodule JiraClient.Command.UserTest do
  use ExUnit.Case
  doctest JiraClient.Command.User

  alias JiraClient.Args
  alias JiraClient.Http.RequestFake

  setup do
    RequestFake.init()
  end

  describe "success" do
    test "user" do
      RequestFake.expect_response(%HTTPotion.Response{body: ~s({
          "accountId": "123"
        }
      )})

      {:ok, args} = Args.parse(["user", "--username", "someuser"])
      {:ok, message} = JiraClient.Command.User.run(args)

      assert message
    end
  end
end
