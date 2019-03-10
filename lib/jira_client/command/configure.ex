defmodule JiraClient.Command.Configure do
  @moduledoc """
    Allow a user to create a configuration file for using this product.
  """

  alias JiraClient.Auth.Configurations

  @behaviour JiraClient.Command

  def run(args) do
    run_with_password(args, fn -> 
      password_get("Enter JIRA passwod: ", true)
    end)
  end

  def run_with_password(args, password_getter) do
    password = String.trim password_getter.()

    Configurations.init(args.username, password)
    {:ok, "Configuration complete"}
  end

  # Password prompt that hides input by every 1ms
  # clearing the line with stderr
  def password_get(prompt, false) do
    IO.gets(prompt <> " ")
  end
  def password_get(prompt, true) do
    pid   = spawn_link(fn -> loop(prompt) end)
    ref   = make_ref()
    value = IO.gets(prompt <> " ")


    send pid, {:done, self(), ref}
    receive do: ({:done, ^pid, ^ref}  -> :ok)

    #String.trim(value)
    value
  end

  defp loop(prompt) do
    receive do
      {:done, parent, ref} ->
        send parent, {:done, self(), ref}
        IO.write :standard_error, "\e[2K\r"
    after
      1 ->
        IO.write :standard_error, "\e[2K\r#{prompt} "
        loop(prompt)
    end
  end
end
