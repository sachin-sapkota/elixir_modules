defmodule HelloWorldServer.Plug do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    IO.puts("Path: #{conn.request_path}")
    IO.puts("Method: #{conn.request_method}")

    conn
    |> route(conn.request_path, conn.request_method)
  end

  def route("/todos", "GET", conn) do
    send_resp(conn, 200, "GET /todos")
  end

  def route("/todos", "POST", conn) do
    send_resp(conn, 200, "POST /todos")
  end

  def route(_, _, conn) do
    send_resp(conn, 404, "Route not found")
  end
end


