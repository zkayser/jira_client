defmodule JiraClient.Api.Request do
  @moduledoc """
    Client for the JIRA REST API.

    Documentation: https://docs.atlassian.com/jira/REST/cloud/
  """

  @doc """
    Allow an arbitrary set of parameters to be formatted into a json string.
  """
  @callback format(Map.t) :: String.t
end
