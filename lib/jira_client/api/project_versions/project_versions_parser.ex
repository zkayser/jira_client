defmodule JiraClient.Api.ProjectVersionsParser do
  @behaviour JiraClient.Api.Parser

  def parse(%HTTPotion.Response{body: body}) do
    parse_data Poison.Parser.parse(body)
  end

  defp parse_data({:ok, data}) do
    {:ok,
      Enum.map(data, fn (version) -> 
        %{
          id:           version["id"],
          description:  version["description"],
          name:         version["name"],
          released:     version["released"],
          release_date: parse_date(Date.from_iso8601(version["releaseDate"])),
          archived:     version["archived"],
          project_id:   version["projectId"]
        }
      end)
    }
  end

  defp parse_date({:ok,    date}), do: date
  defp parse_date({:error, _}),    do: ""
end

