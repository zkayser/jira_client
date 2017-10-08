defmodule JiraClient.Args do

  # Definition of all commands accepted by jira client
  @commands %{
    "help"      => %{
      args:      [],
      aliases:   [],
      mandatory: []
    },
    "configure" => %{
      args:      [username: :string],
      aliases:   [u: :username],
      mandatory: [:username]
    },
    "list_projects" => %{
      args:      [logging: :boolean],
      aliases:   [l: :logging],
      mandatory: []
    },
    "create_issue" => %{
      args:      [project: :string, message: :string, fixVersion: :string, logging: :boolean],
      aliases:   [m: :message, p: :project, f: :fixVersion, l: :logging],
      mandatory: [:project, :message]
    },
    "close_issue" =>  %{
      args:      [issue: :string, logging: :boolean],
      aliases:   [i: :issue, l: :logging],
      mandatory: [:issue]
    }
  }

  @type t :: %JiraClient.Args{
     command:          String.t,
     username:         String.t,
     project:          String.t, # project name
     issue:            String.t,
     fix_version:      String.t,
     message:          String.t,
     close_transition: String.t,
     logging:          Boolean.t
  }
  defstruct command: "", username: "", project: "", issue: "", fix_version: "", message: "", close_transition: "", logging: false

  @spec parse(String.t) :: {Atom.t, JiraClient.Args.t}
  def parse(argv) do
    OptionParser.parse(argv,
      strict:  commands_as_strict_args(@commands),
      aliases: commands_as_aliases(@commands))
    |> validate
    |> new
  end

  defp new({parsed, args, []}) do
    {:ok, %JiraClient.Args{
       command:           hd(args),
       username:          parsed[:username],
       project:           parsed[:project],
       issue:             parsed[:issue],
       fix_version:       normalize_string(parsed[:fixVersion]),
       message:           parsed[:message],
       close_transition:  parsed[:closed_transition],
       logging:           !!parsed[:logging]
    }}
  end

  defp new(message) do
    {:error, message}
  end

  defp validate({_, [], _}) do
    "missing command"
  end

  defp validate({args, [command], invalid}) do
    case Map.has_key?(@commands, command) do
      true  -> validate_args(args, [command], invalid)
      false -> "invalid command: '#{command}'"
    end
  end

  defp validate({_, commands, _}) do
    "only one command please: #{inspect commands}"
  end

  defp validate_args(args, [command], invalid) do
    arg_names = Keyword.keys(args)

    missing_names = Enum.find(@commands[command].mandatory, fn(mandatory_name) -> !Enum.member?(arg_names, mandatory_name) end)
    case missing_names do
      nil  -> {args, [command], invalid}
      _ -> "missing arguments #{inspect missing_names} for #{command} command"
    end
  end

  defp normalize_string(value) do
    if (nil == value), do: "",
    else: value
  end

  # Prepare data for ParseOptions strict argument.
  defp commands_as_strict_args(commands) do
    Enum.reduce(Map.values(commands), [], fn(command, acc) -> acc ++ command.args end)
  end

  # Prepare data for ParseOptions aliases argument.
  defp commands_as_aliases(commands) do
    Enum.reduce(Map.values(commands), [], fn(command, acc) -> acc ++ command.aliases end)
  end
end
