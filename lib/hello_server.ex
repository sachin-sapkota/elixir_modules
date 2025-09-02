defmodule HelloServer do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "Hello, World!")
  end

  get "/json" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, "{\"message\": \"Hello, World!\"}")
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end

  def start_link(_opts) do
    {:ok, _} = Plug.Cowboy.http(__MODULE__, [], port: 4000)
  end
end



