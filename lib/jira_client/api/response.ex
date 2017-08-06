defmodule JiraClient.Api.Response do
  @doc """
    Allow a string response to be converted into an internal data structure.
  """
  @callback parse(String.t) :: Map.t

end
