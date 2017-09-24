defimpl String.Chars, for: HTTPotion.Response do
  def to_string(response) do
    ~s(
    RESPONSE:
    HTTP\/1.1 200 OK
    #{headers(response.headers.hdrs)}

    #{format_body(response.body)}
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

  defp format_body("") do
    "NO BODY"
  end
  defp format_body(body) do
    body
  end
end

