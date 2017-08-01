defmodule JiraClient.Args do

  # Definition of all commands accepted by jira client
  @commands %{
    "create_issue" => %{
      args: [project: :string, message: :string, fixVersion: :string],
      aliases: [m: :message, p: :project, f: :fixVersion],
    },
    "close_issue" =>  %{
      args: [issue: :string],
      aliases: [i: :issue],
    }
  }

  @type t :: %JiraClient.Args{
      command: String.t,
      project: String.t,
      issue: String.t,
      fix_version: String.t,
      message: String.t
    }
  defstruct command: "", project: "", issue: "", fix_version: "", message: ""

  @spec parse(charlist) :: {atom, JiraClient.Args.t}
  def parse(argv) do
    OptionParser.parse(argv,
      strict:  commands_as_strict_args(@commands),
      aliases: commands_as_aliases(@commands))
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

  defp validate({args, [command], invalid}) do
    case Map.has_key?(@commands, command) do
      true  -> validate_command({args, [command], invalid})
      false -> "invalid command: '#{command}'"
    end
  end

  defp validate({_, commands, _}) do
    "only one command please: #{inspect commands}"
  end

  defp validate_command({args, [command], invalid}) do
    expected_args = commands_as_args(@commands, command)
    passed_args   = args |> Keyword.keys |> Enum.sort

    case passed_args == expected_args do
      true  -> {args, [command], invalid}
      false -> "missing arguments for #{command} command"
    end
  end

  # Prepare data for ParseOptions strict argument.
  defp commands_as_strict_args(commands) do
    Enum.reduce(Map.values(commands), [], fn(command, acc) -> acc ++ command.args end)
  end

  # Prepare data for ParseOptions aliases argument.
  defp commands_as_aliases(commands) do
    Enum.reduce(Map.values(commands), [], fn(command, acc) -> acc ++ command.aliases end)
  end

  # Prepare data for comparison with command line args.
  defp commands_as_args(commands, command) do
    commands[command].args
    |> Keyword.keys
    |> Enum.sort
  end
end
