defmodule JiraClient.Api.Formatter do
  @moduledoc """
    Client for the JIRA REST API.

    Documentation: https://docs.atlassian.com/jira/REST/cloud/
  """

  @doc """
    Allow an arbitrary set of parameters to be formatted into a json string.
  """
  @callback format(Map.t) :: {Atom.t, String.t}
end
