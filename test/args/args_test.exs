defmodule JiraClient.ArgsTest do
  use ExUnit.Case
  #doctest JiraClient.Args
  alias JiraClient.Args

  # {[project: "PROJECT ONE", fixVersion: "1.2.3.4", issue: "XXX-123"], ["create_issue"], []}
  test "all args" do
    {:ok, args} = Args.parse(["create_issue", "--project", "PROJECT ONE", "--fixVersion", "1.2.3.4", "--issue", "XXX-123", "--message", "message"])

    assert "create_issue" == args.command
    assert "PROJECT ONE" == args.project
    assert "1.2.3.4" == args.fix_version
    assert "XXX-123" == args.issue
  end

  test "all aliases" do
    {:ok, args} = Args.parse(["create_issue", "-p", "PROJECT ONE", "-f", "1.2.3.4", "-i", "XXX-123", "-m", "message"])

    assert "create_issue" == args.command
    assert "PROJECT ONE" == args.project
    assert "1.2.3.4" == args.fix_version
    assert "XXX-123" == args.issue
  end

  test "invalid arguments" do
    assert {:error, "invalid arguments: {\"--invalid\", nil}"} == Args.parse(["--invalid"])
  end

  test "no command" do
    assert {:error, "missing command"} == Args.parse(["--project", "PROJECT ONE"])
  end

  test "no arguments" do
    assert {:error, "missing arguments"} == Args.parse(["create_issue"])
  end

  #test "no arguments for create_issue" do
    #assert {:error, "missing arguments for create_issue command"} == Args.parse(["create_issue", "--project", "PROJECT ONE", "--fixVersion", "1.2.3.4"]) # missing message
    #assert {:error, "missing arguments for create_issue command"} == Args.parse(["create_issue", "--fixVersion", "1.2.3.4", "--message", "message"])     # missing project
    #assert {:error, "missing arguments for create_issue command"} == Args.parse(["create_issue", "--project", "PROJECT ONE", "--message", "message"])    # missing fix version
  #end

end
