defmodule PhoenixTest.Plug do
  def init(options) do
    options
  end

  def call(conn, _opts) do
    Plug.Conn.resp(conn, 200, \"text/plain\", \"Hello, World!\" )
  end
end
