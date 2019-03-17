defmodule JiraClient.Api.AssignParser do
  @behaviour JiraClient.Api.Parser

  def parse(%HTTPotion.Response{status_code: 204}), do: {:ok, "Success"}
  def parse(%HTTPotion.Response{status_code: 400}), do: {:error, "No user or missing args"}
  def parse(%HTTPotion.Response{status_code: 403}), do: {:error, "No permissions"}
  def parse(%HTTPotion.Response{status_code: 404}), do: {:error, "No issue"}
end
