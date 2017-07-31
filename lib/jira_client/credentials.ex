defmodule JiraClient.Credentials do
  alias JiraClient.Credentials

  @doc """
  Initializes a user's Jira credentials
  """
  @callback init(username :: String.t, password :: String.t) :: __MODULE__.t

  @doc """
  Returns a user's encoded credentials
  """
  @callback get(location :: String.t | atom(), io_module :: atom()) :: __MODULE__.t

  @doc """
  Stores a user's credentials
  """
  @callback store(credentials :: __MODULE__.t) :: __MODULE__.t

  defstruct base64_encoded: "", errors: []
  @type t :: %__MODULE__{
    base64_encoded: String.t,
    errors: [String.t]
  }
end
