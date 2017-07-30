defmodule JiraClient.FileUtilsTest do
  use ExUnit.Case, async: true
  alias JiraClient.FileUtils

  test "make test directory" do
    Path.expand("~") |> File.cd()
    File.rm_rf(".jira_test")
    FileUtils.mkdir_for_credentials(:test)
    assert Path.expand("~") |> Path.join(".jira_test") |> File.exists?
  end

  test "write credentials" do
    FileUtils.write_credentials(:test, "encoded credentials would go here")
    assert FileUtils.creds_file_exists?(:test)
    {:ok, content} = FileUtils.get_creds_file(:test) |> File.read()
    assert "encoded credentials would go here" == String.trim(content)
  end

  test "delete credentials file" do
    FileUtils.write_credentials(:test, "credentials...")
    assert FileUtils.creds_file_exists?(:test)
    
    FileUtils.delete_creds_file(:test)
    refute FileUtils.creds_file_exists?(:test)
  end
end
