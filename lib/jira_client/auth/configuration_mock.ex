defmodule JiraClient.Auth.ConfigurationsMock do
  @behaviour JiraClient.Configurations

  alias JiraClient.Configurations, as: Configuration

  defmodule FakeIO do
    def puts(string), do: string
    def gets("Username: "), do: "username"
    def gets("Password: "), do: "password"
  end

  def init(), do: %Configuration{errors: ["Credentials not provided"]}
  def init("", ""), do: %Configuration{errors: ["Credentials not provided"]}
  def init(username, password) do
    %Configuration{base64_encoded: Base.encode64("#{username}:#{password}")}
    |> store()
  end

  def get() do
    if Application.get_env(:jira_client, :test_creds) do
      creds = Application.get_env(:jira_client, :test_creds)
      %Configuration{base64_encoded: creds}
    else
      FakeIO.puts "Please enter your username and password"
      init(FakeIO.gets("Username: "), FakeIO.gets("Password: "))
    end
  end

  def store(%Configuration{} = creds) do
    Application.put_env(:jira_client, :test_creds, creds.base64_encoded)
    creds
  end
end
