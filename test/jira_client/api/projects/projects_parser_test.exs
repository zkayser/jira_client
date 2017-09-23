defmodule JiraClient.Api.ProjectsParserTest do
  use ExUnit.Case

  alias JiraClient.Api.ProjectsParser

  test "parse response 2 projec" do
    json = ~s([
                {
                    "self": "http://www.example.com/jira/rest/api/2/project/EX",
                    "id": "10000",
                    "key": "EX",
                    "name": "Example",
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
                    "self": "http://www.example.com/jira/rest/api/2/project/ABC",
                    "id": "10001",
                    "key": "ABC",
                    "name": "Alphabetical",
                    "avatarUrls": {
                        "48x48": "http://www.example.com/jira/secure/projectavatar?size=large&pid=10001",
                        "24x24": "http://www.example.com/jira/secure/projectavatar?size=small&pid=10001",
                        "16x16": "http://www.example.com/jira/secure/projectavatar?size=xsmall&pid=10001",
                        "32x32": "http://www.example.com/jira/secure/projectavatar?size=medium&pid=10001"
                    },
                    "projectCategory": {
                        "self": "http://www.example.com/jira/rest/api/2/projectCategory/10000",
                        "id": "10000",
                        "name": "FIRST",
                        "description": "First Project Category"
                    }
                }
            ])

    {:ok, response} = ProjectsParser.parse(%HTTPotion.Response{body: json})

    assert ["Example", "Alphabetical"] = Enum.map(response, fn (project) -> project.name end)
    assert ["EX", "ABC"] = Enum.map(response, fn (project) -> project.key end)
  end

  test "parse invalid json" do
    {:error, "Invalid response: 'invalid, I 0'"} = ProjectsParser.parse(%HTTPotion.Response{body: "INVALID_JSON"})
  end

  test "parse no projects" do
    {:ok, []} = ProjectsParser.parse(%HTTPotion.Response{body: "[]"})
  end
end
