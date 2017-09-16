defmodule JiraClient.Utils.FileUtilsTest do
  use ExUnit.Case

  alias JiraClient.Utils.FileMock
  alias JiraClient.Utils.FileUtils

  setup do
    FileMock.start_link()
    :ok
  end

  test "mkdir_for_credentials" do
    FileUtils.mkdir_for_credentials()

    assert FileUtils.creds_dir_exists?()
  end

  test "write_credentials" do
    FileUtils.mkdir_for_credentials()
    FileUtils.write_credentials("username:password")

    assert FileUtils.creds_file_exists?()
    assert [{FileUtils.get_creds_dir(), 0o700}, {FileUtils.get_creds_file(), 0o600}] == Agent.get(FileMock, &Map.get(&1, "permissions"))
    assert FileMock.read(FileUtils.get_creds_file()) == {:ok, "username:password"}
  end

  test "read credentials" do
    FileUtils.mkdir_for_credentials()
    FileUtils.write_credentials("username:password")

    assert {:ok, "username:password"} == FileUtils.read_credentials()
  end
end

