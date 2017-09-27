defmodule JiraClient.Http.RequestFake do
  alias JiraClient.Http.Request

  def init() do
    with {:ok, _} <- Agent.start_link(fn -> %{requests: [], responses: []} end, name: __MODULE__)
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
    Agent.update(__MODULE__, fn _ -> %{requests: [], responses: []} end)
  end

  def expect_response(response) do
    Agent.update(__MODULE__, fn state -> 
      %{requests: state.requests, responses: state.responses ++ [response]}
    end)
  end

  # TODO this is a 2 message sequence to a single threaded process which could
  # result in a race condition if mutlople tests are running.
  def next_response() do
    next_response = Agent.get(__MODULE__, fn state -> 
        case state.responses do
          [next_response|_] -> next_response
          [] -> ""
        end
      end)
    Agent.update(__MODULE__, fn state -> 
        case state.responses do
          [_|responses] -> %{requests: state.requests, responses: responses}
          [] -> %{requests: state.requests, responses: []}
        end
      end)

    next_response
  end

  # Get the requests that have been tracked
  def next_request() do
    next_request = Agent.get(__MODULE__, fn state -> 
        case state.requests do
          [next_request|_] -> {next_request.http_method, next_request.body, next_request.path}
          [] -> {:none, "", ""}
        end
      end)
    Agent.update(__MODULE__, fn state -> 
        case state.requests do
          [_|requests] -> %{requests: requests, responses: state.responses}
          [] -> %{requests: [], responses: state.responses}
        end
      end)

      next_request
  end

  def new(method, body, path, creds_get_fn \\ fn -> "username:password" end) do
    Request.new(method, body, path, creds_get_fn)
  end

  def send(request, _ \\ false) do
    Agent.update(__MODULE__, fn state -> 
      %{requests: state.requests ++ [request], responses: state.responses}
    end)

    next_response()
  end
end

