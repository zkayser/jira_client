defmodule JiraClient.Command do
  @moduledoc """
    Convert a command name entered on the command lin into a call to the 
    implementation for that command.

    Convention:
    * create_issue maps to CreateIssue
  """

  @doc """
    Each command is implemented as a separate module with a single run metho din it.
    This method must conform to this callback,
  """
  @callback run(JiraClient.Args.t) :: {Atom.t, String.t}

  @doc """
    Dispatch to a command based on the name of the command and its arguments.
  """
  @spec run(String.t, String.t, []) :: {Atom.t, Sring.t}
  def run(command_module, command, args \\ []) do
    module_name = Macro.camelize(Atom.to_string(command_module))
    command_name = Macro.camelize(command)

    with {:ok, module} <- to_module(module_name, command_name),
         {:ok, result} <- run_command(module, args)
    do
      {:ok, result}
    else
      error -> error
    end
  end

  defp to_module(module_name, command_name) do
    try do
      { :ok, module_name <> "." <> command_name |> String.to_existing_atom }
    rescue
      ArgumentError -> {:error, "module doesn't exist: #{module_name <> "." <> command_name}"}
    end
  end

  defp run_command(module, args) do
    try do
      # TODO why do i need an extra set of [] on the args in the apply?
      apply(module, :run, [ args ])
    rescue
      ArgumentError -> {:error, "module doesn't exist: #{module}"}
    end
  end
end

