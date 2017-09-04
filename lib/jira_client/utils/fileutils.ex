defmodule JiraClient.Utils.FileUtils do
  @creds_file "credentials.txt"
  @creds_dir ".jira"

  @file_module Application.get_env(:jira_client, :file_module, File)

  def mkdir_for_credentials do
    unless Path.expand("~") |> Path.join(@creds_dir) |> @file_module.exists?() do
      Path.expand("~") |> @file_module.cd()
      @file_module.mkdir(@creds_dir)
    end
  end

  def write_credentials(credentials) do
    Path.expand("~")
    |> Path.join(@creds_dir)
    |> @file_module.cd()
    @file_module.write(@creds_file, credentials)

    # Ensure only the user can read the file.
    @file_module.chmod(@creds_dir, 0o700)
    @file_module.chmod(@creds_file, 0o600)
  end

  def read_credentials() do
    {:ok, @file_module.read(get_creds_file())}
  end

  def creds_file_exists?(), do: get_creds_file() |> @file_module.exists?()

  def creds_dir_exists?(), do: get_creds_dir() |> @file_module.exists?()

  def get_creds_file(), do: Path.expand("~") |> Path.join("#{@creds_dir}/#{@creds_file}")

  def get_creds_dir(), do: Path.expand("~") |> Path.join("#{@creds_dir}")

  def delete_creds_file(), do: @file_module.rm_rf(get_creds_file())

  def creds_file, do: @creds_file
  def creds_dir, do: @creds_dir
end

