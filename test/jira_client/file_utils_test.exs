defmodule JiraClient.FileUtilsTest do
  use ExUnit.Case

  defmodule FileMock do

    def cd(path) when is_binary(path)  do

    end

    def mkdir(path) when is_binary(path) do

    end

    def write(path, content) when is_binary(path) do

    end

    def read(path) when is_binary(path) do

    end

    def exists?(path) when is_binary(path) do

    end

    def rm_rf(path) when is_binary(path) do

    end
  end
  
end
