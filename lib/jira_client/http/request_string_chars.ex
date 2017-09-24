defimpl String.Chars, for: JiraClient.Http.Request do
  def to_string(request) do
    method = request.http_method |> Kernel.to_string |> String.upcase

    ~s(
    REQUEST:
    #{method} #{request.path}
    #{headers(request.headers)}

    #{format_body(request.body)}
    )
  end

  defp headers(header_list) do
    format_headers(header_list, "")
  end

  defp format_headers([], text), do: text
  defp format_headers([{:Authorization, _}|other_headers], text), do: format_headers(other_headers, text)
  defp format_headers([{name, value}|other_headers], text) do
    format_headers(other_headers, text <> "#{name}: #{value}\r\n    ")
  end

  defp format_body("") do
    "NO BODY"
  end
  defp format_body(body) do
    body
  end
end

