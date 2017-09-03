defmodule JiraClient.Api.Parser do
  @callback parse(%HTTPotion.Response{}) :: {Atom, %{}}
end

