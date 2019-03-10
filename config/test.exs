use Mix.Config
Code.require_file("lib/jira_client/http/request.ex")
Code.require_file("test/jira_client/http/request_fake.ex")

config :jira_client, 
  credentials_module: JiraClient.Auth.ConfigurationsMock,
  command_module:     JiraClientTest.CommandFake,
  request_module:     JiraClient.Http.RequestFake,
  file_module:        JiraClient.Utils.FileMock

