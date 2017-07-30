defmodule JiraClient.FileUtils do
  @creds_file "credentials.txt"
  @creds_dir ".jira"
  @test_creds_dir ".jira_test"

  def mkdir_for_credentials(env \\ :dev) do
    case env do
      :dev -> mkdir(@creds_dir)
      :test -> mkdir(@test_creds_dir)
    end
  end

  defp mkdir(dir_name) do
    unless Path.expand("~") |> Path.join(dir_name) |> File.exists?() do
      Path.expand("~") |> File.cd()
      File.mkdir(dir_name)
    end
  end

  def write_credentials(env \\ :dev, credentials) do
    case env do
      :dev -> do_write_credentials(@creds_dir, credentials)
      :test -> do_write_credentials(@test_creds_dir, credentials)
    end
  end

  defp do_write_credentials(dir_name, credentials) do
    Path.expand("~")
    |> Path.join(dir_name)
    |> File.cd()
    File.write(@creds_file, credentials)
  end

  def creds_file_exists?(env \\ :dev) do
    case env do
      :dev -> check_file_exists(".jira/credentials.txt")
      :test -> check_file_exists(".jira_test/credentials.txt")
    end
  end

  defp check_file_exists(file), do: Path.expand("~") |> Path.join(file) |> File.exists?()

  def get_creds_file(env \\ :dev) do
    case env do
      :dev -> Path.expand("~") |> Path.join("#{@creds_dir}/#{@creds_file}")
      :test -> Path.expand("~") |> Path.join("#{@test_creds_dir}/#{@creds_file}")
    end
  end

  def creds_file, do: @creds_file
  def creds_dir(:dev), do: @creds_dir
  def creds_dir(:test), do: @test_creds_dir
end
