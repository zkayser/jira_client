defmodule JiraClient.Utils.FileUtils do
  @creds_file "credentials.txt"
  @creds_dir ".jira"

  def mkdir_for_credentials(file_mod \\ File) do
    unless Path.expand("~") |> Path.join(@creds_dir) |> file_mod.exists?() do
      Path.expand("~") |> file_mod.cd()
      file_mod.mkdir(@creds_dir)
    end
  end

  def write_credentials(file_mod \\ File, credentials) do
    Path.expand("~")
    |> Path.join(@creds_dir)
    |> file_mod.cd()
    file_mod.write(@creds_file, credentials)

    # Ensure only the user can read the file.
    file_mod.chmod(@creds_dir, 0o700)
    file_mod.chmod(@creds_file, 0o600)

  end

  def creds_file_exists?(file_mod \\ File), do: Path.expand("~") |> Path.join("#{@creds_dir}/#{@creds_file}") |> file_mod.exists?()

  def get_creds_file(), do: Path.expand("~") |> Path.join("#{@creds_dir}/#{@creds_file}")

  def delete_creds_file(file_mod \\ File), do: file_mod.rm_rf(get_creds_file())

  def creds_file, do: @creds_file
  def creds_dir, do: @creds_dir
end
