defmodule JiraClient.Command.CreateIssue do
  @moduledoc """
    Creates a JIRA issue related to a project, with a speciric fixVersion.
  """

  alias JiraClient.Api.CreateIssue,          as: ApiCreateIssue
  alias JiraClient.Api.CreateIssueFormatter, as: ApiCreateIssueFormatter
  alias JiraClient.Api.CreateIssueParser,    as: ApiCreateIssueParser

  alias JiraClient.Api.Projects,             as: ApiProjects
  alias JiraClient.Api.ProjectsParser,       as: ApiProjectsParser

  @behaviour JiraClient.Command

  def run(args) do
    with {:ok, project_id} <- find_project(args.project),
         {:ok, issue}      <- create_issue(project_id, args.message, args.fix_version)
    do
      {:ok, "Created #{issue.issue_id}"}
    end
  end

  defp find_project(project_name) do
    with {:ok, response} <- ApiProjects.send(%{}),
         {:ok, projects} <- ApiProjectsParser.parse(response),
         {:ok, project}  <- select_project(project_name, projects)
    do
      {:ok, project.key}
    end
  end

  defp create_issue(project_id, message, fix_version) do
    with request         <- ApiCreateIssueFormatter.format(%{project_id: project_id, message: message, fix_version: fix_version}),
         {:ok, response} <- ApiCreateIssue.send(request),
         {:ok, issue}    <- ApiCreateIssueParser.parse(response)
    do
      {:ok, issue}
    else
      error -> {:error, error}
    end
  end

  defp select_project(project_name, projects) do
    case Enum.find(projects, &(project_name == &1.name)) do
      nil       -> {:error, "No project called '#{project_name}'"}
      project   -> {:ok, project}
    end
  end
end

