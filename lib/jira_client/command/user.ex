defmodule JiraClient.Command.User do
  @moduledoc """
    Get some user information
    """

  alias JiraClient.Api.GetUser,          as: ApiGetUser
  alias JiraClient.Api.GetUserParser,    as: ApiGetUserParser

  @behaviour JiraClient.Command

  def run(args) do
    with {:ok, user} <- get_user(args.username, args.logging)
    do
      {:ok, "#{inspect user}"}
    else
      message -> message
    end
  end

  defp get_user(username, logging) do
    with {:ok, response} <- ApiGetUser.send(%{username: username}, "", logging),
         {:ok, user}     <- ApiGetUserParser.parse(response)
    do
      {:ok, user}
    else
      message -> {:error, message}
    end
  end
end
