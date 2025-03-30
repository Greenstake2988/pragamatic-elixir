defmodule Servy.HttpClient do
  def client() do
    request = ~c"""
    GET /api/bears HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    \r
    """

    some_host_in_net = ~c"localhost"
    {:ok, sock} = :gen_tcp.connect(some_host_in_net, 4000, [:binary, packet: :raw, active: false])
    :ok = :gen_tcp.send(sock, request)
    :ok = :gen_tcp.close(sock)
  end
end
