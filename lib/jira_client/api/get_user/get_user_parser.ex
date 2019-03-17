defmodule JiraClient.Api.GetUserParser do
  @behaviour JiraClient.Api.Parser

  def parse(%HTTPotion.Response{body: body}) do
    parse_data Poison.Parser.parse(body)
  end

  defp parse_data({:ok, data}) do
    {:ok,
      %{
        username: data["name"],
        email: data["emailAddress"],
        accountId: data["accountId"],
        displayName: data["displayName"],
        active: data["active"],
        timeZone: data["timeZone"],
        locale: data["locale"]
      }
    }
  end

end
