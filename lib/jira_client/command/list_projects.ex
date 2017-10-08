defmodule JiraClient.Command.ListProjects do
  @moduledoc """
    Lis all the projects
  """

  alias JiraClient.Api.Projects,             as: ApiProjects
  alias JiraClient.Api.ProjectsParser,       as: ApiProjectsParser

  @behaviour JiraClient.Command

  def run(args) do
    with {:ok, response} <- ApiProjects.send(%{}, "", args.logging),
         {:ok, projects} <- ApiProjectsParser.parse(response)
    do
      projects = Enum.map(projects, fn project -> project.name end)
      |> Enum.join("\r\n")

      {:ok, projects}
    end
  end
end

