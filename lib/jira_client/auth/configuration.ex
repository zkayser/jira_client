defmodule JiraClient.Auth.Configurations do
  @moduledoc """
  This module contains functions for authenticating with the Jira
  Api using basic authentication
  """

  @behaviour JiraClient.Configurations

  alias JiraClient.Configurations, as: Configuration
  alias JiraClient.Utils.FileUtils

  def init(), do: build_credentials(nil)
  def init("", ""), do: build_credentials(nil)
  def init(_, {:error, _}), do: build_credentials(nil)
  def init(username, pass) do
    encode(username, pass)
    |> build_credentials()
    |> store()
  end

  def get() do
    with true <- FileUtils.creds_file_exists?(),
      {:ok, contents} <- FileUtils.read_credentials()
    do
      {:ok, json} = Poison.Parser.parse(contents)
      json["base64_encoded"]
    else
      false ->
        IO.puts "Your credentials have not been configured. Run the following command for access your Jira instance: "
        IO.puts "jira_client configure --username <jira username> --password <jira password>"
      {:error, reason} ->
        IO.puts "Something went wrong: #{reason}"
    end
  end

  def store(%Configuration{errors: errors}) when length(errors) > 0 do
     IO.puts "There is an error or errors with your credentials:\n#{for error <- errors, do: IO.inspect(error)}"
     IO.puts "Please try again."
     get()
  end

  def store(%Configuration{base64_encoded: encoded} = configuration) do
    {:ok, contents} = Poison.encode(%{
      base64_encoded: encoded
    })

    FileUtils.mkdir_for_credentials()
    FileUtils.write_credentials(contents)

    configuration
  end

  def encode(username, pass) do
    "#{username}:#{pass}"
    |> Base.encode64()
  end

  defp build_credentials(nil), do: %Configuration{errors: ["Credentials not provided"]}
  defp build_credentials(encoded_credentials) do
    %Configuration{base64_encoded: encoded_credentials}
  end
end