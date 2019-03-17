defmodule JiraClient.Api.GetUserParserTest do
  use ExUnit.Case

  alias JiraClient.Api.GetUserParser

  test "parse id" do
    json = """
      {
        "self": "http://your-domain.atlassian.net/rest/api/2/user?accountId=99:27935d01-92a7-4687-8272-a9b8d3b2ae2e",
        "key": "mia",
        "accountId": "99:27935d01-92a7-4687-8272-a9b8d3b2ae2e",
        "name": "mia",
        "emailAddress": "mia@example.com",
        "avatarUrls": {
          "48x48": "http://your-domain.atlassian.net/secure/useravatar?size=large&ownerId=mia",
          "24x24": "http://your-domain.atlassian.net/secure/useravatar?size=small&ownerId=mia",
          "16x16": "http://your-domain.atlassian.net/secure/useravatar?size=xsmall&ownerId=mia",
          "32x32": "http://your-domain.atlassian.net/secure/useravatar?size=medium&ownerId=mia"
        },
        "displayName": "Mia Krystof",
        "active": true,
        "timeZone": "Australia/Sydney",
        "groups": {
          "size": 3,
          "items": []
        },
        "applicationRoles": {
          "size": 1,
          "items": []
        }
      }
    """
    {:ok, data} = GetUserParser.parse(%HTTPotion.Response{body: json})

    assert data.account_id == "99:27935d01-92a7-4687-8272-a9b8d3b2ae2e";
  end
end

