defmodule JiraClient.Utils.FileUtilsTest do
  use ExUnit.Case

  defmodule FileMock do
    def start_link do
      Agent.start_link(fn -> %{} end, name: __MODULE__)
    end

    def cd(path) when is_binary(path)  do
      case Agent.get(__MODULE__, fn state -> path in Map.keys(state) end) do
        true -> :ok
        _ -> {:error, :enoent}
      end
    end

    def chmod(path, mod) when is_binary(path) do
      Agent.update(__MODULE__, &Map.put(&1, path, mod))
    end

    def mkdir(path) when is_binary(path) do
      # Agent.update(__MODULE__, &Map.put(&1, path, ""))
      fn () -> write(path, "") end
    end

    def write(path, content) when is_binary(path) do
      Agent.update(__MODULE__, &Map.put(&1, path, content))
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
  end
end
