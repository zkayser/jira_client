defmodule JiraClient.Configurations do

  @doc """
  Initializes a user's Jira credentials
  """
  @callback init(username :: String.t, api_token :: String.t) :: __MODULE__.t

  @doc """
  Returns a user's encoded credentials
  """
  @callback get() :: __MODULE__.t

  @doc """
  Stores a user's credentials
  """
  @callback store(credentials :: __MODULE__.t) :: __MODULE__.t

  defstruct base64_encoded: "", jira_server: "", errors: []
  @type t :: %__MODULE__{
    base64_encoded: String.t,
    jira_server: String.t,
    errors: [String.t]
  }
end
