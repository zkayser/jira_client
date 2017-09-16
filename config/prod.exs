use Mix.Config

config :jira_client, 
  base_url:           "https://plxistools.atlassian.net",
  credentials_module: JiraClient.Auth.Credentials,
  command_module:     JiraClient.Command,
  request_module:     JiraClient.Http.Request,
  file_module:        File

