defmodule JiraClient.Api.ProjectVersionsParserTest do
  use ExUnit.Case
  doctest JiraClient.Api.ProjectVersionsParser

  alias JiraClient.Api.ProjectVersionsParser

  test "parse response" do
    json = ~s([
      {
         "self": "http://www.example.com/jira/rest/api/2/version/10000",
         "id": "10000",
         "description": "An excellent version",
         "name": "New Version 1",
         "archived": false,
         "released": true,
         "releaseDate": "2010-07-06",
         "overdue": true,
         "userReleaseDate": "6/Jul/2010",
         "projectId": 10000
      },
      {
         "id": "20000",
         "description": "Another excellent version",
         "name": "New Version 2",
         "archived": true,
         "released": false,
         "releaseDate": "",
         "projectId": 123
      }
    ])


    {:ok, response} = ProjectVersionsParser.parse(%HTTPotion.Response{body: json})

    version = List.first(response)
    assert version.id == "10000"
    assert version.description == "An excellent version"
    assert version.name == "New Version 1"
    assert version.released == true
    assert version.release_date == ~D[2010-07-06]
    assert version.archived == false
    assert version.project_id == 10000

    version = List.last(response)
    assert version.id == "20000"
    assert version.description == "Another excellent version"
    assert version.name == "New Version 2"
    assert version.released == false
    assert version.release_date == ""
    assert version.archived == true
    assert version.project_id == 123
  end

  test "if there are no versions created for the project" do
    json = ~s([])
 
    {:ok, response} = ProjectVersionsParser.parse(%HTTPotion.Response{body: json})

    assert Enum.empty?(response)
  end
end
