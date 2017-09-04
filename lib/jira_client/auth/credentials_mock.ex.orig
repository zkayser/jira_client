defmodule JiraClient.Auth.TestCredentials do
  @behaviour JiraClient.Credentials

  alias JiraClient.Credentials, as: Creds

  defmodule FakeIO do
    def puts(string), do: string
    def gets("Username: "), do: "username"
    def gets("Password: "), do: "password"
  end

  def init(), do: %Creds{errors: ["Credentials not provided"]}
  def init("", ""), do: %Creds{errors: ["Credentials not provided"]}
  def init(username, password) do
    %Creds{base64_encoded: Base.encode64("#{username}:#{password}")}
    |> store()
  end

  def get(_) do
    if Application.get_env(:jira_client, :test_creds) do
      creds = Application.get_env(:jira_client, :test_creds)
      %Creds{base64_encoded: creds}
    else
      FakeIO.puts "Please enter your username and password"
      init(FakeIO.gets("Username: "), FakeIO.gets("Password: "))
    end
  end

  def store(%Creds{} = creds) do
    Application.put_env(:jira_client, :test_creds, creds.base64_encoded)
    creds
  end
end
