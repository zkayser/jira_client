defmodule JiraClient.Api.Sender do
  @callback send(Map.t, String.t, Boolean.t) :: {Atom.t, %{}}
end

