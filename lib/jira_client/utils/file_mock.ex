defmodule JiraClient.Utils.FileMock do
  @moduledoc """
  Mimics a selection of calls used on the standard library File module
  to prevent modification of the file system during test runs. A fake file
  system is created and stored in an Agent process.
  """

  def start_link do
    Agent.start_link(&initialize/0, name: __MODULE__)
  end

  def du() do
    Agent.get(__MODULE__, fn state -> state end)
  end

  def mkdir(path) when is_binary(path) do
    Agent.update(__MODULE__, &Map.put(&1, path, ""))
  end

  def write(path, content) when is_binary(path) do
    Agent.update(__MODULE__, &Map.put(&1, path, content))
  end

  def read(path) when is_binary(path) do
    {:ok, Agent.get(__MODULE__, &Map.get(&1, path))}
  end

  def exists?(path) when is_binary(path) do
    Agent.get(__MODULE__, fn state -> path in Map.keys(state) end)
  end

  def rm_rf(path) when is_binary(path) do
    Agent.update(__MODULE__, &Map.delete(&1, path))
  end

  def chmod(path, permissions) do
    existing_permissions = Agent.get(__MODULE__, &Map.get(&1, "permissions"))
    existing_permissions = existing_permissions ++ [{path, permissions}]
    Agent.update(__MODULE__, &Map.put(&1, "permissions", existing_permissions))
  end

  defp initialize do
    %{}
    |> Map.put("permissions", [])
    |> Map.put(Path.expand("~"), "")
  end
end

