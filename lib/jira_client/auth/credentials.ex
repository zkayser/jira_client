defmodule JiraClient.Auth.Credentials do
  alias JiraClient.Auth.Credentials
  @moduledoc """
  This module contains functions for authenticating with the Jira
  Api using basic authentication
  """

  defstruct base64_encoded: "", errors: []

  def init("", ""), do: build_credentials(nil)
  def init(), do: build_credentials(nil)
  def init(username, pass) do
    "#{username}:#{pass}"
    |> Base.encode64()
    |> build_credentials()
  end


  defp build_credentials(nil), do: %Credentials{errors: ["Credentials not provided"]}
  defp build_credentials(encoded_credentials) do
    %Credentials{base64_encoded: encoded_credentials}
  end
end
