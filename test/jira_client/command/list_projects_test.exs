defmodule JiraClient.Command.ListProjectsTest do
  use ExUnit.Case
  doctest JiraClient.Command.ListProjects

  alias JiraClient.Args
  alias JiraClient.Http.RequestFake

  setup do
    RequestFake.init()
  end

  test "list projects" do
    RequestFake.expect_response(%HTTPotion.Response{body: ~s(
     [
       {
         "self": "http://www.example.com/jira/rest/api/2/project/EX",
         "id": "10000",
         "key": "PROJECT-123",
         "name": "Example 1",
         "avatarUrls": {
           "48x48": "http://www.example.com/jira/secure/projectavatar?size=large&pid=10000",
           "24x24": "http://www.example.com/jira/secure/projectavatar?size=small&pid=10000",
           "16x16": "http://www.example.com/jira/secure/projectavatar?size=xsmall&pid=10000",
           "32x32": "http://www.example.com/jira/secure/projectavatar?size=medium&pid=10000"
         },
         "projectCategory": {
           "self": "http://www.example.com/jira/rest/api/2/projectCategory/10000",
           "id": "10000",
           "name": "FIRST",
           "description": "First Project Category"
         }
       },
       {
         "self": "http://www.example.com/jira/rest/api/2/project/EX",
         "id": "10000",
         "key": "PROJECT-123",
         "name": "Example 2",
         "avatarUrls": {
           "48x48": "http://www.example.com/jira/secure/projectavatar?size=large&pid=10000",
           "24x24": "http://www.example.com/jira/secure/projectavatar?size=small&pid=10000",
           "16x16": "http://www.example.com/jira/secure/projectavatar?size=xsmall&pid=10000",
           "32x32": "http://www.example.com/jira/secure/projectavatar?size=medium&pid=10000"
         },
         "projectCategory": {
           "self": "http://www.example.com/jira/rest/api/2/projectCategory/10000",
           "id": "10000",
           "name": "FIRST",
           "description": "First Project Category"
         }
       }
     ])})

    {:ok, output} = JiraClient.Command.run(JiraClient.Command, "list_projects", %Args{})

    assert Regex.match?(~r/Example 1/, output)
    assert Regex.match?(~r/Example 2/, output)
  end
end

