defmodule JiraClient.ArgsTest do
  use ExUnit.Case, async: true
  alias JiraClient.Args

  describe "command help" do

    test "help" do
      {:ok, args} = Args.parse(["help"])

      assert args.command == "help"
    end
  end

  describe "http logging" do
    test "enable" do
      {:ok, args} = Args.parse(["create_issue", "-p", "project", "-m", "message", "--logging"])

      assert args.logging == true
    end

    test "intentionally disabled" do
      {:ok, args} = Args.parse(["create_issue", "-p", "project", "-m", "message", "--no-logging"])

      assert args.logging == false
    end

    test "disabled" do
      {:ok, args} = Args.parse(["create_issue", "-p", "project", "-m", "message"])

      assert args.logging == false
    end
  end

  describe "command configure" do

    test "configure username" do
      {:ok, args} = Args.parse(["configure", "--username", "fred"])

     assert args.command == "configure"
     assert args.username == "fred"
    end

    test "configure username short form" do
      {:ok, args} = Args.parse(["configure", "-u", "fred"])

     assert args.command == "configure"
     assert args.username == "fred"
    end

    test "missing username" do
      {:error, "missing arguments :username for configure command"} = Args.parse(["configure"])
    end
  end

  describe "command create_issue" do
    test "create_issue all args" do
      {:ok, args} = Args.parse(["create_issue", "--project", "PROJECT ONE", "--fixVersion", "1.2.3.4", "--message", "message"])

      assert "create_issue" == args.command
      assert "PROJECT ONE" == args.project
      assert "1.2.3.4" == args.fix_version
    end

    test "create_issue all aliases" do
      {:ok, args} = Args.parse(["create_issue", "-p", "PROJECT ONE", "-f", "1.2.3.4", "-m", "message"])

      assert "create_issue" == args.command
      assert "PROJECT ONE" == args.project
      assert "1.2.3.4" == args.fix_version
    end

    test "fix version is optional" do
      {:ok, args} = Args.parse(["create_issue", "--project", "PROJECT ONE", "--message", "message"])

      assert "create_issue" == args.command
      assert "PROJECT ONE" == args.project
      assert "message" == args.message
      assert "" == args.fix_version
    end

    test "create_issue missing argument" do
      assert {:error, "missing arguments :message for create_issue command"} == 
        Args.parse(["create_issue", "--project", "PROJECT ONE", "--fixVersion", "1.2.3.4"]) # missing message

      assert {:error, "missing arguments :project for create_issue command"} == 
        Args.parse(["create_issue", "--fixVersion", "1.2.3.4", "--message", "message"])     # missing project
    end
   end

  describe "command close_issue" do

    test "close_issue all args" do
      {:ok, args} = Args.parse(["close_issue", "--issue", "XXX-123"])

      assert "XXX-123" == args.issue_id
    end

    test "close_issue all aliases" do
      {:ok, args} = Args.parse(["close_issue", "-i", "XXX-123"])

      assert "XXX-123" == args.issue_id
    end

    test "close_issue missing argument" do
      expected_error = {:error, "missing arguments :issue for close_issue command"}
      assert expected_error == Args.parse(["close_issue"]) # missing issue
    end
  end

  describe "command list projects" do

    test "select command" do
      {:ok, args} = Args.parse(["list_projects"])

      assert "list_projects" == args.command
    end
  end

  describe "assign command" do
    test "run" do
      {:ok, args} = Args.parse(["assign", "--issue", "XXX-123", "--username", "somename"])

      assert "assign" == args.command
      assert "XXX-123" == args.issue_id
      assert "somename" == args.username
    end
  end

  describe "command user" do
    test "get user info" do
      {:ok, args} = Args.parse(["user", "--username", "somename"])

      assert "user" == args.command
      assert "somename" == args.username
    end
  end

  describe "argument validation" do

    test "no command" do
      assert {:error, "missing command"} == Args.parse(["--project", "PROJECT ONE"])
    end

    test "invalid command" do
      assert {:error, "invalid command: 'invalid_command'"} == Args.parse(["invalid_command", "--project", "PROJECT ONE"])
    end

    test "multiple command 2" do
      assert {:error, "only one command please: [\"invalid1\", \"invalid2\"]"} == 
        Args.parse(["invalid1", "invalid2", "--project", "PROJECT ONE"])
    end

    test "multiple command 3" do
      assert {:error, "only one command please: [\"invalid1\", \"invalid2\", \"invalid3\"]"} == 
        Args.parse(["invalid1", "invalid2", "invalid3", "--project", "PROJECT ONE"])
    end
  end
end
