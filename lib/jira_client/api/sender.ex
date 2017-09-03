defmodule JiraClient.Api.Sender do
  @callback send(String.t) :: {Atom, %{}}
end

