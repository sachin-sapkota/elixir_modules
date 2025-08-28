defmodule HelloWorldServer do
  use Plug.Router
  require Logger

  plug Plug.Logger
  plug :match
  plug Plug.Parsers, parsers: [:json], pass: ["application/json"]
  plug :dispatch

  get "/todos" do
    send_resp(conn, 200, "Get all todos")
  end

  get "/todos/:id" do
    send_resp(conn, 200, "Get todo with ID: #{id}")
  end

  post "/todos" do
    send_resp(conn, 200, "Create new todo")
  end

  put "/todos/:id" do
    send_resp(conn, 200, "Update todo with ID: #{id}")
  end

  delete "/todos/:id" do
    send_resp(conn, 200, "Delete todo with ID: #{id}")
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end

