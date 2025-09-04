defmodule ElixirModules.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    ElixirModules.Handler.call(conn, [])
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end
end

