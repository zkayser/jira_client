defimpl String.Chars, for: HTTPotion.Response do
  def to_string(response) do
    ~s(
    RESPONSE:
    HTTP\/1.1 200 OK
    #{headers(response.headers.hdrs)}

    #{response.body}
    )
  end

  defp headers(headers) do
    Enum.reduce(headers, "", fn ({name, value}, text) ->
      text <> "#{correct_case(name)}: #{value}\r\n    "
    end)
  end

  defp correct_case(name) do
    String.split(name, "-")
    |> Enum.map(fn(part) -> String.capitalize(part) end)
    |> Enum.join("-")
  end
end

