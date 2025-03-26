defmodule Servy.BearController do
  alias Servy.WildThings
  alias Servy.Bear

  defp bear_item(bear) do
    "<li>#{bear.name} - #{bear.type}</li>"
  end

  def index(conv) do
    items =
      WildThings.list_bears()
      |> Enum.filter(&Bear.is_grizzly/1)
      |> Enum.sort(&Bear.order_asc_by_name/2)
      |> Enum.map(&bear_item/1)
      |> Enum.join()

    %{conv | status: 200, resp_body: items}
  end

  def create(conv, %{"name" => name, "type" => type}) do
    %{conv | status: 201, resp_body: "Create Bears name: #{name} type: #{type}"}
  end

  def show(conv, %{"id" => id}) do
    bear = WildThings.get_bear(id)
    %{conv | status: 200, resp_body: "<h1>Bear: #{bear.id}, Name: #{bear.name} </h1>"}
  end

  def destroy(conv, %{"id" => id}) do
    bear = WildThings.get_bear(id)
    %{conv | status: 403, resp_body: "you can't delete bear #{bear.name}"}
  end
end
