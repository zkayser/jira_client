defmodule JiraClient.Command.Help do
  def run(_) do
    {:ok, ~s(usage: jira_client [command] [arguments]

      Commands:
      configure --username "esumerfield"
      list_projects
      create_issue --project "PROJECT A" --message "this is an issue" [--fixVersion "1.2.3"]
      close_issue --issue "ABC-123"
      assign --issue "ABC-123" --username <your jira username>

      Common arguments for all commands
      [--logging] can be added to produce API logging.
    )}
  end
end

