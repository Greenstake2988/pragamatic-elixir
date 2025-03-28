defmodule Sum do
  def sum([head | tail], acc) do
    sum(tail, head + 4 )
  end

  def sum([], acc) do
  end
end
