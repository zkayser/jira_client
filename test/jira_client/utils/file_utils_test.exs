defmodule JiraClient.Utils.FileUtilsTest do
  alias JiraClient.Utils.FileMock
  alias JiraClient.Utils.FileUtils
  use ExUnit.Case

  setup do
    FileMock.start_link()
    :ok
  end

  test "mkdir_for_credentials" do
    FileUtils.mkdir_for_credentials(FileMock)
    assert FileUtils.creds_dir_exists?(FileMock)
  end

  test "write_credentials" do
    FileUtils.mkdir_for_credentials(FileMock)
    FileUtils.write_credentials(FileMock, "username:password")
    assert FileUtils.creds_file_exists?(FileMock)
    assert [{FileUtils.creds_dir(), 0o700}, {FileUtils.creds_file(), 0o600}] == Agent.get(FileMock, &Map.get(&1, "permissions"))
    assert FileUtils.get_creds_file |> FileMock.read() == "username:password"
  end
end
