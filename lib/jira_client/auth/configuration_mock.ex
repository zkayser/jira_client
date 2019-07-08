defmodule JiraClient.Auth.ConfigurationsMock do
  @behaviour JiraClient.Configurations

  alias JiraClient.Configurations, as: Configuration

  defmodule FakeIO do
    def puts(string), do: string
    def gets("Username: "), do: "username"
    def gets("API Token: "), do: "api_token"
  end

  def init(), do: %Configuration{errors: ["Credentials not provided"]}
  def init("", ""), do: %Configuration{errors: ["Credentials not provided"]}
  def init(username, api_token) do
    %Configuration{base64_encoded: Base.encode64("#{username}:#{api_token}")}
    |> store()
  end

  def get() do
    if Application.get_env(:jira_client, :test_creds) do
      creds = Application.get_env(:jira_client, :test_creds)
      %Configuration{base64_encoded: creds}
    else
      FakeIO.puts "Please enter your username and api token"
      init(FakeIO.gets("Username: "), FakeIO.gets("API Token: "))
    end
  end

  def store(%Configuration{} = creds) do
    Application.put_env(:jira_client, :test_creds, creds.base64_encoded)
    creds
  end
end
