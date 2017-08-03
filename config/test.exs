use Mix.Config

config :jira_client, 
  base_url: System.get_env("JIRA_BASE_URL"),
  test_credentials: JiraClient.Auth.TestCredentials,
  command_module: JiraClientTest.CommandFake

