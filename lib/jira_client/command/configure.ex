defmodule JiraClient.Command.Configure do
  @moduledoc """
    Allow a user to create a configuration file for using this product.
  """

  alias JiraClient.Auth.Configurations

  @behaviour JiraClient.Command

  def run(args) do
    run_with_inputs(args, fn -> 
      domain = domain_get("Enter JIRA domain (https://YOURCOMPANY.atlassian.net)")
      api_token = api_token_get("Enter JIRA API token: ", true)
      [api_token, domain]
    end)
  end

  def run_with_inputs(args, inputs_getter) do
    case inputs_getter.() do
      [api_token, jira_server] ->  Configurations.init(args.username, String.trim(api_token), String.trim(jira_server))
    end
    
    {:ok, "Configuration complete"}
  end

  def domain_get(prompt) do
    IO.gets(prompt <> " ")
  end

  # API Token prompt that hides input by every 1ms
  # clearing the line with stderr
  def api_token_get(prompt, false) do
    IO.gets(prompt <> " ")
  end
  def api_token_get(prompt, true) do
    pid   = spawn_link(fn -> loop(prompt) end)
    ref   = make_ref()
    value = IO.gets(prompt <> " ")

    send pid, {:done, self(), ref}
    receive do: ({:done, ^pid, ^ref}  -> :ok)

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
