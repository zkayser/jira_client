defmodule JiraClient.Api.CloseIssueFormatter do
  @moduledoc """
  Documentation from https://developer.atlassian.com/cloud/jira/platform/rest/#api-api-2-issue-issueIdOrKey-transitions-post
  {
    "update": {
      "comment": [
        {
          "add": {
              "body": "Bug has been fixed."
          }
        }
      ]
    },
    "fields": {
      "assignee": {
        "name": "bob"
      },
      "resolution": {
        "name": "Fixed"
      }
    },
    "transition": {
        "id": "5"
    },
    "historyMetadata": {
        "type": "myplugin:type",
        "description": "text description",
        "descriptionKey": "plugin.changereason.i18.key",
        "activityDescription": "text description",
        "activityDescriptionKey": "plugin.activity.i18.key",
        "actor": {
            "id": "tony",
            "displayName": "Tony",
            "type": "mysystem-user",
            "avatarUrl": "http://mysystem/avatar/tony.jpg",
            "url": "http://mysystem/users/tony"
        },
        "generator": {
            "id": "mysystem-1",
            "type": "mysystem-application"
        },
        "cause": {
            "id": "myevent",
            "type": "mysystem-event"
        },
        "extraData": {
            "keyvalue": "extra data",
            "goes": "here"
        }
    }
}
  """
  @behaviour JiraClient.Api.Formatter

  def format(request) do
    Poison.encode(%{
      transition: %{
        id: request.transition_id
      }
    })
  end
end

