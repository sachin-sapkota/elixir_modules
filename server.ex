defmodule Server do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "Hello, World!")
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end

  def init(options) do
    options
  end

  def call(conn, options) do
    super(conn, options)
  end
end


