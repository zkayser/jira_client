use Mix.Config

config :jira_client, 
  credentials_module: JiraClient.Auth.Credentials,
  command_module:     JiraClient.Command,
  request_module:     JiraClient.Http.Request,
  file_module:        File

