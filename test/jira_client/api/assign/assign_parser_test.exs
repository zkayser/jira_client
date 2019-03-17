defmodule JiraClient.Api.AssignParserTest do
  use ExUnit.Case

  alias JiraClient.Api.AssignParser

  test "success" do
    assert {:ok, "Success"} == AssignParser.parse(%HTTPotion.Response{body: "", status_code: 204})
  end

  test "No uesr or missing args" do
    assert {:error, "No user or missing args"} == AssignParser.parse(%HTTPotion.Response{body: "", status_code: 400})
  end

  test "User doesnt have permissions" do
    assert {:error, "No permissions"} == AssignParser.parse(%HTTPotion.Response{body: "", status_code: 403})
  end

  test "failed to find issue" do
    assert {:error, "No issue"} == AssignParser.parse(%HTTPotion.Response{body: "", status_code: 404})
  end

end

