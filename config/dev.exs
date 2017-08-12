use Mix.Config

config :jira_client, 
  base_url: System.get_env("JIRA_BASE_URL"),
  test_credentials: JiraClient.Auth.Credentials,
  command_module:   JiraClient.Command,
  request_module:   JiraClient.Http.Request,
  file_module:      File

