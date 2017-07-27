defmodule JiraClient.Args do
  defstruct command: "", project: "", issue: "", fix_version: "", message: ""

  @command_args %{
    create_issue: [:project, :fixVersion, :message],
    close_issue:  [:issue]
  }

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

  defp validate({args, ["create_issue"], invalid}) do
    case Enum.map(args, &(elem(&1,0))) == @command_args.create_issue do
      false -> "missing arguments for create_issue command"
      true  -> {args, ["create_issue"], invalid}
    end
  end

  defp validate({args, ["close_issue"], invalid}) do
    case Enum.map(args, &(elem(&1,0))) == @command_args.close_issue do
      false -> "missing arguments for close_issue command"
      true  -> {args, ["close_issue"], invalid}
    end
  end

  defp validate({_, [command], _}) do
      "invalid command: '#{command}'"
  end

  defp validate(args) do
    args
  end

end
