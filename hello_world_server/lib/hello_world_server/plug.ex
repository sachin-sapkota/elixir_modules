defmodule HelloWorldServer.Plug do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    case conn.method do
      "GET" ->
        send_resp(conn, 200, "Hello from GET!")
      "POST" ->
        send_resp(conn, 200, "Hello from POST!")
      _ ->
        send_resp(conn, 404, "Not Found")
    end
  end
end
