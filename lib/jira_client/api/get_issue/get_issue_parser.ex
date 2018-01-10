defmodule JiraClient.Api.GetIssueParser do
  @behaviour JiraClient.Api.Parser

  def parse(%HTTPotion.Response{body: body}) do
    parse_data Poison.Parser.parse(body)
  end

  defp parse_data({:ok, data}) do
    {:ok,
      %{
        id: data["id"],
      }
    }
  end

end
