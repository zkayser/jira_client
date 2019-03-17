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
    with {:ok, project_id}     <- find_project(args.project, args.logging),
         {:ok, fix_version_id} <- select_fix_version(project_id, args.fix_version, args.logging),
         {:ok, issue}          <- create_issue(project_id, args.message, fix_version_id, args.logging)
    do
      {:ok, "#{issue.issue_id}"}
    end
  end

  defp find_project(project_name, logging) do
    with {:ok, response} <- ApiProjects.send(%{}, "", logging),
         {:ok, projects} <- ApiProjectsParser.parse(response),
         {:ok, project}  <- select_project(project_name, projects)
    do
      {:ok, project.key}
    end
  end

  defp select_fix_version(project_id, entered_fix_version, logging) do
    with {:ok, response}       <- ApiProjectVersions.send(%{project_id: project_id}, "", logging),
         {:ok, fix_versions}   <- ApiProjectVersionsParser.parse(response),
         {:ok, fix_version_id} <- entered_or_latest(fix_versions, entered_fix_version)
    do
      {:ok, fix_version_id}
    end
  end

  ## If there is not fix version entered then choose the latest
  defp entered_or_latest(fix_versions, "") do
    case fix_versions do
      [] -> {:error, "No fix version specified and project has none"}
      _  -> find_latest_fixversion(fix_versions)
    end
  end

  defp entered_or_latest(fix_versions, entered_fix_version) do
    found_fix_version = Enum.find(fix_versions, fn fix_version -> fix_version.name == entered_fix_version end)
    case found_fix_version do
      nil -> {:error, "couldnt find fix version"}
      _   -> {:ok, found_fix_version.id}
    end
  end

  defp find_latest_fixversion(fix_versions) do
    sorted_fix_versions = Enum.sort(fix_versions, fn fix_version_a, fix_version_b -> fix_version_a.id <= fix_version_b.id end)
    found_fix_version = List.last(sorted_fix_versions)
    {:ok, found_fix_version.id}
  end

  defp create_issue(project_id, message, fix_version_id, logging) do
    with {:ok, request}  <- ApiCreateIssueFormatter.format(%{project_id: project_id, message: message, fix_version: fix_version_id}),
         {:ok, response} <- ApiCreateIssue.send(%{}, request, logging),
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

