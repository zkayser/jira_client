defimpl String.Chars, for: HTTPotion.Response do
  def to_string(response) do
    ~s(
    RESPONSE:
    HTTP\/1.1 200 OK
    #{header(response, "Date")}
    #{header(response, "Connection")}
    #{header(response, "Server")}
    #{header(response, "Content-Type")}
    )
  end

  defp header(response, name) do
    "#{name}: #{response.headers.hdrs[String.downcase(name)]}"
  end
end

