defimpl String.Chars, for: HTTPotion.ErrorResponse do
  def to_string(response) do
    ~s(
    ERROR RESPONSE:
    #{inspect response}
    )
  end
end


