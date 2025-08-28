defmodule TodoBackend do
  @moduledoc """
  A simple todo backend server using Plug and Cowboy.
  """

  use Plug.Router
  require Logger

  plug :match
  plug :dispatch

  # In-memory store for todos
  @todos Agent.start_link(fn -> %{} end, name: :todos_agent)

  # Helper to send JSON responses
  defp send_json(conn, status, body) do
    conn
    |> Plug.Conn.put_resp_header("content-type", "application/json")
    |> send_resp(status, Jason.encode!(body))
  end

  # GET /todos - List all todos
  get "/todos" do
    todos = Agent.get(:todos_agent, & &1)
    send_json(conn, 200, Enum.map(todos, fn {id, todo} -> Map.put(todo, :id, id) end))
  end

  # POST /todos - Create a new todo
  post "/todos" do
    with {:ok, %{"title" => title}} <- Plug.Conn.read_json(conn) do
      id = Ecto.UUID.generate()
      todo = %{title: title, completed: false}
      Agent.update(:todos_agent, fn todos -> Map.put(todos, id, todo) end)
      send_json(conn, 201, Map.put(todo, :id, id))
    else
      _ -> send_resp(conn, 400, "Bad Request")
    end
  end

  # GET /todos/:id - Get a specific todo
  get "/todos/:id" do
    id = Plug.Router.match(conn, "/todos/:id")[:id]
    case Agent.get(:todos_agent, &Map.get(&1, id)) do
      nil -> send_resp(conn, 404, "Not Found")
      todo -> send_json(conn, 200, Map.put(todo, :id, id))
    end
  end

  # PUT /todos/:id - Update a specific todo
  put "/todos/:id" do
    id = Plug.Router.match(conn, "/todos/:id")[:id]
    with {:ok, %{"title" => title, "completed" => completed}} <- Plug.Conn.read_json(conn),
         true <- Agent.get(:todos_agent, &Map.has_key?(&1, id)) do
      updated_todo = %{title: title, completed: completed}
      Agent.update(:todos_agent, fn todos -> Map.put(todos, id, updated_todo) end)
      send_json(conn, 200, Map.put(updated_todo, :id, id))
    else
      false -> send_resp(conn, 404, "Not Found")
      _ -> send_resp(conn, 400, "Bad Request")
    end
  end

  # DELETE /todos/:id - Delete a specific todo
  delete "/todos/:id" do
    id = Plug.Router.match(conn, "/todos/:id")[:id]
    case Agent.get(:todos_agent, &Map.has_key?(&1, id)) do
      true ->
        Agent.update(:todos_agent, fn todos -> Map.delete(todos, id) end)
        send_resp(conn, 204, "")
      false ->
        send_resp(conn, 404, "Not Found")
    end
  end

  def start(_type, _args) do
    Plug.Cowboy.start_link(scheme: :http, plug: __MODULE__, options: [port: 4000])
  end
end


