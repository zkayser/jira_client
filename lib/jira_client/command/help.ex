defmodule JiraClient.Command.Help do
  def run(_) do
    {:ok, ~s(usage: jira_client [command] [arguments]

      Commands:
      create_issue --project "PROJECT A" --fixVersion "1.2.3" --message "this is an issue"
    )}
  end
end

