defmodule JiraClient.Api.CloseIssueParser do

  @behaviour JiraClient.Api.Parser

  def parse(%HTTPotion.Response{status_code: 200}), do: {:ok, "Success"}
  def parse(%HTTPotion.Response{status_code: 204}), do: {:ok, "Success"}
  def parse(%HTTPotion.Response{status_code: 404}), do: {:error, "No issue found"}
end
