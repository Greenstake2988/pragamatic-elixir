defmodule Recurse do
  def sum([head | tail], acc ) do
    IO.puts "Head: #{head} Tail: #{inspect(tail)}"

    sum(tail, acc + head)
  end

  def sum([], acc), do: acc

  def triple([head | tail]) do
    [head * 3 | triple( tail)]
  end

  def triple([]), do: []



  def triple_tailOPT(list) do
    triple_tailOPT(list, [])
  end

  defp triple_tailOPT([head|tail], current_list) do
    triple_tailOPT(tail, [head*3 | current_list])
  end

  defp triple_tailOPT([], current_list) do
    current_list |> Enum.reverse()
  end

  def new_map([head | tail], fun) do
    [fun.(head) | new_map(tail, fun)]
  end

  def new_map([], _fun), do: []

  def parse_headers(headers_lines) do
    Enum.reduce(headers_lines, %{}, fn(line, acc) ->
      [key, value] = String.split(line, ": ")
      Map.put(acc, key, value)
    end)
  end


end

Recurse.sum([1,2,3,4,5], 0)

IO.inspect Recurse.triple_tailOPT([1,2,3,4,5])

IO.inspect Recurse.new_map([1,2,3,4,5], &(&1 + 5))

headers = ["Host: example.com", "User-Agent: ExampleBrowser/1.0", "Accept: */",
"Content-Type: application/x-www-form-urlencoded",
"Content-Length: 21"]

IO.inspect Recurse.parse_headers(headers)
