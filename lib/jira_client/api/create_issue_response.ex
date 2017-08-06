defmodule JiraClient.Api.CreateIssueResponse do
  @moduledoc """
    {
        "id": "10000",
        "key": "TST-24",
        "self": "http://www.example.com/jira/rest/api/2/issue/10000"
    }
  """

  @behaviour JiraClient.Api.Response

  def parse(response) do
    %{value: response}
  end
end

