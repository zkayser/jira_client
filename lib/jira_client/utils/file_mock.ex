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

  def cd(path) when is_binary(path)  do
    case Agent.get(__MODULE__, fn state -> path in Map.keys(state) end) do
      true ->
        Agent.update(__MODULE__, &Map.put(&1, "cwd", path))
        :ok
      _ -> {:error, :enoent}
    end
  end

  def mkdir(path) when is_binary(path) do
    cwd = Agent.get(__MODULE__, &Map.get(&1, "cwd"))
    new_dir = cwd <> "/" <> path
    Agent.update(__MODULE__, &Map.put(&1, new_dir, ""))
  end

  def cwd, do: Agent.get(__MODULE__, &Map.get(&1, "cwd"))

  def write(path, content) when is_binary(path) do
    cwd = Agent.get(__MODULE__, &Map.get(&1, "cwd"))
    Agent.update(__MODULE__, &Map.put(&1, cwd <> "/" <> path, content))
  end

  def read(path) when is_binary(path) do
    Agent.get(__MODULE__, &Map.get(&1, path))
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
    {:ok, cwd} = File.cwd()
    String.split(cwd, "/")
    |> Enum.drop(1)
    |> Enum.reduce([], &build_paths(&1, &2))
    |> Enum.reduce(%{}, fn path, acc -> Map.put(acc, path, "") end)
    |> Map.put("cwd", cwd)
    |> Map.put("permissions", [])
    |> Map.put(Path.expand("~"), "")
  end

  defp build_paths(elem, []), do: ["/" <> elem]
  defp build_paths(elem, [head|_] = list) do
    [head <> "/" <> elem] ++ list
  end
end
