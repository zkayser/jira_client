defmodule JiraClient.Command.CreateIssue do
  @moduledoc """
    Creates a JIRA issue related to a project, with a speciric fixVersion.
  """

  alias JiraClient.Api.CreateIssue,          as: ApiCreateIssue
  alias JiraClient.Api.CreateIssueFormatter, as: ApiCreateIssueFormatter
  alias JiraClient.Api.CreateIssueParser,    as: ApiCreateIssueParser

  alias JiraClient.Api.ProjectVersions,      as: ApiProjectVersions
  alias JiraClient.Api.ProjectVersionsParser,as: ApiProjectVersionsParser

  alias JiraClient.Api.Projects,             as: ApiProjects
  alias JiraClient.Api.ProjectsParser,       as: ApiProjectsParser

  @behaviour JiraClient.Command

  def run(args) do
    with {:ok, project_id}     <- find_project(args.project),
         {:ok, fix_version_id} <- select_fix_version(project_id, args.fix_version),
         {:ok, issue}          <- create_issue(project_id, args.message, fix_version_id)
    do
      {:ok, "Created #{issue.issue_id}"}
    end
  end

  defp find_project(project_name) do
    with {:ok, response} <- ApiProjects.send(%{}, ""),
         {:ok, projects} <- ApiProjectsParser.parse(response),
         {:ok, project}  <- select_project(project_name, projects)
    do
      {:ok, project.key}
    end
  end

  defp select_fix_version(project_id, entered_fix_version) do
    with {:ok, response}       <- ApiProjectVersions.send(%{project_id: project_id}, ""),
         {:ok, fix_versions}   <- ApiProjectVersionsParser.parse(response),
         {:ok, fix_version_id} <- entered_or_latest(fix_versions, entered_fix_version)
    do
      {:ok, fix_version_id}
    end
  end

  ## If there is not fix version entered then choose the latest
  defp entered_or_latest(fix_versions, nil) do
    sorted_fix_versions = Enum.sort(fix_versions, fn fix_version_a, fix_version_b -> fix_version_a.id <= fix_version_b.id end)
    found_fix_version = List.last(sorted_fix_versions)
    {:ok, found_fix_version.id}
  end

  defp entered_or_latest(fix_versions, entered_fix_version) do
    found_fix_version = Enum.find(fix_versions, fn fix_version -> fix_version.name == entered_fix_version end)
    {:ok, found_fix_version.id}
  end

  defp create_issue(project_id, message, fix_version_id) do
    with {:ok, request}  <- ApiCreateIssueFormatter.format(%{project_id: project_id, message: message, fix_version: fix_version_id}),
         {:ok, response} <- ApiCreateIssue.send(%{}, request),
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

