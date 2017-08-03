defmodule JiraClient.Command do
  defmacro left >>> right do
    quote do
      (fn ->
        case unquote(left) do
          {:ok, x} -> x |> unquote(right)
          {:error, _} = expr -> expr
        end
      end).()
    end
  end

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
      {:ok,  apply(module, :run, [ args ])}
    rescue
      ArgumentError -> {:error, "module doesn't exist: #{module}"}
    end
  end
end

