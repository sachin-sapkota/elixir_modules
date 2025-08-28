defmodule HelloWorldServer do
  use Plug.Router
  require Logger

  alias HelloWorldServer.TodoStore

  plug Plug.Logger
  plug :match
  plug Plug.Parsers, parsers: [:json], pass: ["application/json"]
  plug :dispatch

  get "/todos" do
    todos = TodoStore.all()
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(todos))
  end

  get "/todos/:id" do
    id = String.to_integer(id)
    case TodoStore.get(id) do
      nil ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, Jason.encode!(%{error: "Todo not found"}))
      todo ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Jason.encode!(todo))
    end
  end

  post "/todos" do
    with {:ok, %{"title" => title}} <- Jason.decode(conn.request_body)
    do
      {:ok, _} = TodoStore.create(title)
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(201, Jason.encode!(%{message: "Todo created"}))
    else
      _ ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(400, Jason.encode!(%{error: "Invalid request body"}))
    end
  end

  put "/todos/:id" do
    id = String.to_integer(id)
    with {:ok, attrs} <- Jason.decode(conn.request_body)
    do
      case TodoStore.get(id) do
        nil ->
          conn
          |> put_resp_content_type("application/json")
          |> send_resp(404, Jason.encode!(%{error: "Todo not found"}))
        _ ->
          {:ok, _} = TodoStore.update(id, attrs)
          conn
          |> put_resp_content_type("application/json")
          |> send_resp(200, Jason.encode!(%{message: "Todo updated"}))
      end
    else
      _ ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(400, Jason.encode!(%{error: "Invalid request body"}))
    end
  end

  delete "/todos/:id" do
    id = String.to_integer(id)
    case TodoStore.get(id) do
      nil ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(404, Jason.encode!(%{error: "Todo not found"}))
      _ ->
        {:ok, _} = TodoStore.delete(id)
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(204, "")
    end
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end


