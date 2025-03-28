defmodule Servy.Parser do
  alias Servy.Conv

  def parse(request) do
    [top, params_string] = request |> String.split("\r\n\r\n", parts: 2)

    [request_line | header_lines] = top |> String.split("\r\n")

    [method, path, _] = request_line |> String.split(" ")

    headers = parse_headers(header_lines)

    params = parse_params(headers["Content-Type"], params_string)

    %Conv{
      method: method,
      path: path,
      params: params,
      headers: headers
    }
  end

  def parse_headers(header_lines) do
    Enum.reduce(header_lines, %{}, fn line, acc ->
      [key, value] = String.split(line, ": ")
      Map.put(acc, key, value)
    end)
  end

  @doc """
  Parses the given param string of the form `key1=value&key2=value2`
  into a map with corresponding keys and values.

  ## Examples
      iex> params_string = "name=Baloo&type=Brown"
      iex> Servy.Parser.parse_params("application/x-www-form-urlencoded", params_string)
      %{"name" => "Baloo", "type" => "Brown"}
      iex> Servy.Parser.parse_params("multipart/from-data", params_string)
      %{}
  """
  def parse_params("application/x-www-form-urlencoded", params_string) do
    params_string |> String.trim() |> URI.decode_query()
  end

  def parse_params(_content_type, _params_string), do: %{}
end
