defmodule JiraClient.Utils.FileMockTest do
  use ExUnit.Case

  alias JiraClient.Utils.FileMock

  setup do
    FileMock.start_link
    :ok
  end

  test "file does not exists" do
    assert !FileMock.exists?("NO FILE")
  end

  test "file exists" do
    FileMock.write("path/file", "contents")

    assert FileMock.exists?(FileMock.cwd() <> "/path/file")
  end
  
  test "file contents" do
    FileMock.write("path/file", "contents")
    
    assert "contents" == FileMock.read(FileMock.cwd() <> "/path/file")
  end
end

