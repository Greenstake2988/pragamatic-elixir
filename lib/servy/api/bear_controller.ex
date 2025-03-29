defmodule Servy.Api.BearController do
  import Servy.Plugins, only: [put_resp_content_type: 2]

  def index(conv) do
    json =
      Servy.WildThings.list_bears()
      |> Jason.encode!()

    conv = put_resp_content_type(conv, "application/json")
    %{conv | status: 200, resp_body: json}
  end

  def create(conv, %{"name" => name, "type" => type}) do
    %{conv | status: 201, resp_body: "Created a #{type} bear named #{name}!"}
  end
end
