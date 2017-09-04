use Mix.Config

config :jira_client, 
  base_url:         "https://vpsadm.ipcoop.com/jira",
  credentials_module: JiraClient.Auth.Credentials,
  command_module:   JiraClient.Command,
  request_module:   JiraClient.Http.Request,
  file_module:      File

