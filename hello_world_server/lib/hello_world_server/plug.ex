defmodule HelloWorldServer.Plug do
  use Plug.Router

  plug :match
  plug :dispatch

  # Get all todos
  get "/todos" do
    todos = HelloWorldServer.Repo.all(HelloWorldServer.Todo)
    send_resp(conn, 200, Poison.encode!(todos))
  end

  # Get a single todo
  get "/todos/:id" do
    id = String.to_integer(id)
    case HelloWorldServer.Repo.get(HelloWorldServer.Todo, id) do
      nil -> send_resp(conn, 404, "Not Found")
      todo -> send_resp(conn, 200, Poison.encode!(todo))
    end
  end

  # Create a todo
  post "/todos" do
    body = Plug.Conn.read_body(conn)
    {:ok, params} = Poison.decode(body)
    changeset = HelloWorldServer.Todo.changeset(%HelloWorldServer.Todo{}, params)

    case HelloWorldServer.Repo.insert(changeset) do
      {:ok, todo} -> send_resp(conn, 201, Poison.encode!(todo))
      {:error, _changeset} -> send_resp(conn, 400, "Bad Request")
    end
  end

  # Update a todo
  put "/todos/:id" do
    id = String.to_integer(id)
    body = Plug.Conn.read_body(conn)
    {:ok, params} = Poison.decode(body)
    todo = HelloWorldServer.Repo.get!(HelloWorldServer.Todo, id)
    changeset = HelloWorldServer.Todo.changeset(todo, params)

    case HelloWorldServer.Repo.update(changeset) do
      {:ok, todo} -> send_resp(conn, 200, Poison.encode!(todo))
      {:error, _changeset} -> send_resp(conn, 400, "Bad Request")
    end
  end

  # Delete a todo
  delete "/todos/:id" do
    id = String.to_integer(id)
    todo = HelloWorldServer.Repo.get!(HelloWorldServer.Todo, id)
    HelloWorldServer.Repo.delete(todo)
    send_resp(conn, 204, "")
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end


