defmodule Servy.BearController do
  alias Servy.WildThings
  alias Servy.Bear

  import Servy.View, only: [render: 3]

  def index(conv) do
    bears =
      WildThings.list_bears()
      |> Enum.sort(&Bear.order_asc_by_name/2)

    render(conv, "index", bears: bears)
  end

  def create(conv, %{"name" => name, "type" => type}) do
    %{conv | status: 201, resp_body: "Created a #{type} bear named #{name}!"}
  end

  def show(conv, %{"id" => id}) do
    bear =
      WildThings.get_bear(id)

    render(conv, "show", bear: bear)
  end

  def destroy(conv) do
    %{conv | status: 403, resp_body: "you can't delete bear"}
  end
end
