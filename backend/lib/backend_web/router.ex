defmodule BackendWeb.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/hello" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, ~s({"message": "Hello, world!"}))
  end

  match _ do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(404, ~s({"error": "Not found"}))
  end
end
