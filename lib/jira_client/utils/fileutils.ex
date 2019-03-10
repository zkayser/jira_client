defmodule JiraClient.Utils.FileUtils do
  @creds_dir ".jira"
  @creds_file "credentials.json"

  @file_module Application.get_env(:jira_client, :file_module, File)

  def mkdir_for_credentials do
    unless creds_dir_exists?() do
      @file_module.mkdir(get_creds_dir())
    end
  end

  def write_credentials(credentials) do
    @file_module.write(get_creds_file(), credentials)

    # Ensure only the user can read the file.
    @file_module.chmod(get_creds_dir(), 0o700)
    @file_module.chmod(get_creds_file(), 0o600)
  end

  def read_credentials() do
    @file_module.read(get_creds_file())
  end

  def creds_dir_exists?(),  do: @file_module.exists?(get_creds_dir())
  def creds_file_exists?(), do: @file_module.exists?(get_creds_file())

  def delete_creds_file(), do: @file_module.rm_rf(get_creds_file())

  def get_creds_dir(),  do: Path.join creds_root(), creds_dir()
  def get_creds_file(), do: Path.join get_creds_dir(), creds_file()

  defp creds_root, do: Path.expand("~")
  defp creds_dir,  do: @creds_dir
  defp creds_file, do: @creds_file
end

