defmodule JiraClient.Utils.FileUtilsTest do
  alias JiraClient.Utils.FileMock
  alias JiraClient.Utils.FileUtils
  use ExUnit.Case

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
    assert [{FileUtils.creds_dir(), 0o700}, {FileUtils.creds_file(), 0o600}] == Agent.get(FileMock, &Map.get(&1, "permissions"))
    assert FileUtils.get_creds_file |> FileMock.read() == "username:password"
  end
end

