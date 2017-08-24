defmodule JiraClient.Http.RequestFake do
  alias JiraClient.Http.Request

  def init() do
    with {:ok, _} <- Agent.start_link(fn -> [] end, name: __MODULE__)
    do
      :ok
    else
      {:error, {:already_started, _}} -> 
        clear()
        :ok
      result -> 
        IO.puts("Agent start failed #{inspect result}")
        :error
    end
  end

  def clear() do
    Agent.update(__MODULE__, fn _ -> [] end)
  end

  def expect_response(response) do
    Agent.update(__MODULE__, fn responses -> 
        responses ++ [response]
      end)
  end

  def next_response() do
    next_response = Agent.get(__MODULE__, fn responses -> 
        case responses do
          [next_response|_] -> next_response
          [] -> ""
        end
      end)
    Agent.update(__MODULE__, fn responses -> 
        case responses do
          [_|responses] -> responses
          [] -> ""
        end
      end)

    next_response
  end

  def new(method, body, path, creds_get_fn \\ fn -> "username:password" end) do
    %Request{
      headers: ["Content-Type": "application/json", "Authorization": "Basic #{creds_get_fn.()}"],
      body: body,
      path: path,
      base_url: Application.get_env(:jira_client, :base_url),
      http_method: method
    }
  end

  def send(_) do
    next_response = next_response()

    {:ok, next_response}
  end
end

