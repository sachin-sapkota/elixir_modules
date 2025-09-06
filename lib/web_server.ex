defmodule WebServer do
  import Plug.Conn

  def init(options) do
    options
  end

  def call(conn, _opts) do
    case conn.method do
      "GET" ->
        case conn.request_path do
          "/hello" -> send_resp(conn, 200, "Hello, World!")
          _ -> send_resp(conn, 404, "Not Found")
        end
      _ -> send_resp(conn, 405, "Method Not Allowed")
    end
  end
end
