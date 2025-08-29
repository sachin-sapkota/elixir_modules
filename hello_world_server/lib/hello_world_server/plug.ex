defmodule HelloWorldServer.Plug do
  import Plug.Conn

  def init(opts), do: opts

  def call(%Plug.Conn{method: "GET", path_info: ["hello"]} = conn, _opts) do
    send_resp(conn, 200, "hello you have reached sachin")
  end

  def call(conn, _opts), do: send_resp(conn, 404, "Not Found")
end
