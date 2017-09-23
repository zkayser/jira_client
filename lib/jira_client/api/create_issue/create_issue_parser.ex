defmodule JiraClient.Api.CreateIssueParser do
  @moduledoc """
    {
        "id": "10000",
        "key": "TST-24",
        "self": "http://www.example.com/jira/rest/api/2/issue/10000"
    }
  """

  @behaviour JiraClient.Api.Parser

  def parse(%HTTPotion.Response{body: body}) do
    parse_data Poison.Parser.parse(body)
  end

  defp parse_data({:ok, data}) do
    {:ok,
      %{
       issue_id: data["key"]
      }
    }
  end
end

