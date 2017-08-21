defmodule JiraClient.Api.CloseIssueRequest do
  @moduledoc """
  Documentation from https://docs.atlassian.com/jira/REST/cloud/#api/2/issue-doTransition
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
  @behaviour JiraClient.Api.Request

  def format(request) do
    Poison.encode(%{
      transitions: %{
        id: request.close_transition
      }
    })
  end
end
