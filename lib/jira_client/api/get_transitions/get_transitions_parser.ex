defmodule JiraClient.Api.GetTransitionsParser do
  @behaviour JiraClient.Api.Parser

  def parse(%HTTPotion.Response{body: body}) do
    parse_data Poison.Parser.parse(body)
  end

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

end
