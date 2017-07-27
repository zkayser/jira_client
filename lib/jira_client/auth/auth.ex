defmodule JiraClient.Auth do
  @moduledoc """
  The Jira Rest API requires authentication using one of three approaches:

  1) Basic Http authentication
  2) Oauth
  3) Cookie-based authentication

  This module provides functionality for configuring authentication methods
  to the API.
  """
  @valid_methods [:basic, :oauth, :cookie]
  @default System.get_env("JIRA_AUTH_METHOD")

  def set_auth(method) when method in @valid_methods do
    Application.put_env(:jira_client, :auth_method, method)
  end

  def set_auth(_), do: :error

  def get_auth, do: Application.get_env(:jira_client, :auth_method)
end
