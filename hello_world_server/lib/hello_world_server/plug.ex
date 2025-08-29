defmodule HelloWorldServer.Plug do
  import Plug.Conn
  import URI

  def init(opts), do: opts

  def call(conn, _opts) do
    case {conn.method, conn.request_path} do
      {"GET", "/"} ->
        send_resp(conn, 200, "Hello from GET!")

      {"POST", "/"} ->
        {:ok, body, conn} = read_body(conn)
        params = decode_query(body)
        name = Map.get(params, "name", "stranger")
        send_resp(conn, 200, "Hello, #{name}!")

      _ ->
        send_resp(conn, 404, "Not Found")
    end
  end
end

