defmodule JiraClient.Api.ProjectsParser do
  @moduledoc """
    Documentation: https://docs.atlassian.com/jira/REST/cloud/?_ga=2.164234879.1341041118.1503016110-979192388.1493054306#api/2/project-getAllProjects
  """
  
  @behaviour JiraClient.Api.Parser

  def parse(response) do
    parse_response Poison.Parser.parse(response)
  end

  defp parse_response({:ok, project_list}) do
    {:ok,
      parse_project(project_list, [])
    }
  end

  defp parse_response({:error, error}) do
    {:error, "Invalid response: 'invalid, #{elem(error, 1)} #{elem(error, 2)}'"}
  end

  defp parse_project([], projects), do: projects
  defp parse_project([project| the_rest], projects) do
    project = %{
      name: project["name"],
      key:  project["key"]
    }
    parse_project(the_rest, projects ++ [ project ])
  end
end

