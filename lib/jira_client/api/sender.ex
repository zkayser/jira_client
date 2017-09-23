defmodule JiraClient.Api.Sender do
  @callback send(Map.t, String.t) :: {Atom.t, %{}}
end

