defmodule JiraClient.Args do
  defstruct command: "", project: "", issue: "", fix_version: "", message: ""

  @command_args %{
    create_issue: [:project, :fixVersion, :message],
    close_issue:  [:issue]
  }

  @valid_commands ~w(create_issue close_issue)

  @doc """
    command      action to be taken
    --message    A summary to add to the issue
    --project    [JIRA project name or id]
    --issue      [JIRA issue number]
    --fixVersion [JIRA project fix version]

    Output:
      {[:ok|:error], Args}
  """
  def parse(argv) do
    OptionParser.parse(argv,
      strict: [project: :string, message: :string, issue: :string, fixVersion: :string],
      aliases: [m: :message, p: :project, f: :fixVersion, i: :issue])
    |> validate
    |> new
  end

  defp new({parsed, args, []}) do
    {:ok, %JiraClient.Args{
       command:       hd(args),
       project:       parsed[:project],
       issue:         parsed[:issue],
       fix_version:   parsed[:fixVersion],
       message:       parsed[:message]
    }}
  end

  defp new(message) do
    {:error, message}
  end

  defp validate({_, _, [invalid]}) do
    "invalid arguments: #{inspect invalid}"
  end

  defp validate({_, [], _}) do
    "missing command"
  end

  defp validate({args, [command], invalid}) when command in @valid_commands do
    with given_args_keys <- args |> Keyword.keys |> Enum.sort,
      command_atom <- String.to_existing_atom(command),
      required_keys <- @command_args[command_atom] |> Enum.sort,
      true <- given_args_keys == required_keys
    do
      {args, [command], invalid}
    else
      false -> "missing arguments for #{command} command"
    end
  end

  defp validate({_, [command], _}) do
    "invalid command: '#{command}'"
  end

  defp validate({_, commands, _}) do
    "only one command please: #{inspect commands}"
  end

  defp validate(args) do
    args
  end
end
