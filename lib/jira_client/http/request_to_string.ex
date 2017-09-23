defimpl String.Chars, for: JiraClient.Http.Request do
  def to_string(request) do
    method = request.http_method |> Kernel.to_string |> String.upcase

    ~s(
    REQUEST:
    #{method} #{request.path}
    #{header(request, "Content-Type")}
    #{header(request, "Authorization")}

    #{request.body}
    )
  end

  defp header(request, name) do
    "#{name}: #{request.headers[String.to_atom(name)]}"
  end
end

