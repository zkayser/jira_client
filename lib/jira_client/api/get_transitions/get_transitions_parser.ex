defmodule JiraClient.Api.GetTransitionsParser do
  @behaviour JiraClient.Api.Parser

  def parse(%HTTPotion.Response{body: body}) do
    parse_data Poison.Parser.parse(body)
  end

  defp parse_data({:error, _}),                    do: {:error, "No transitions"}
  defp parse_data({:ok, empty}) when empty == %{}, do: {:error, "No transitions"}
  defp parse_data({:ok, %{transitions: []}}),      do: {:error, "No transitions"}
  defp parse_data({:ok, data}) do
    {:ok,
      Enum.map(data["transitions"], fn (transition) -> 
        %{
          id:    transition["id"],
          name:  transition["name"]
        }
      end)
    }
  end

  # {"errorMessages":["Issue does not exist or you do not have permission to see it."],"errors":{}}
  # {:error, :invalid, 0}

end
