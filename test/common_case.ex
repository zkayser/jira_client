defmodule JiraClient.CommonCase do
  use ExUnit.CaseTemplate
  using do
    quote do
      Code.require_file("test/jira_client/http/request_fake.ex")
    end
  end
end
