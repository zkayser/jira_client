defmodule JiraClient.Command do
  def run(command_module, command, args) do
    module_name = Macro.camelize(Atom.to_string(command_module))
    command_name = Macro.camelize(command)
    module = String.to_existing_atom(module_name <> "." <> command_name)

    # TODO why do i need an extra set of [] on the args?
    {:ok,  apply(module, :run, [ args ]) }
  end
end
