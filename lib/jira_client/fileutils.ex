defmodule JiraClient.FileUtils do
  @creds_file "credentials.txt"
  @creds_dir ".jira"

  def mkdir_for_credentials do
    unless Path.expand("~") |> Path.join(@creds_dir) |> File.exists?() do
      Path.expand("~") |> File.cd()
      File.mkdir(@creds_dir)
    end
  end

  def write_credentials(credentials) do
    Path.expand("~")
    |> Path.join(@creds_dir)
    |> File.cd()
    File.write(@creds_file, credentials)
  end

  def creds_file_exists?, do: Path.expand("~") |> Path.join("#{@creds_dir}/#{@creds_file}") |> File.exists?()

  def get_creds_file, do: Path.expand("~") |> Path.join("#{@creds_dir}/#{@creds_file}")

  def delete_creds_file, do: File.rm_rf(get_creds_file())

  def creds_file, do: @creds_file
  def creds_dir, do: @creds_dir
end
