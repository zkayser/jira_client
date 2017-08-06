defmodule JiraClient.Command.CreateIssue do
  @moduledoc """
    Creates a JIRA issue related to a project, with a speciric fixVersion.
  """

  @behaviour JiraClient.Command

  def run(args) do
    {:ok, inspect args}
  end
end
