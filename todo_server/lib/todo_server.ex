defmodule TodoServer do
  use Plug.Router

  plug :match
  plug :dispatch

  def start_link(_) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  get "/todos" do
    todos = Agent.get(__MODULE__, & &1) |> Map.values()
    send_resp(conn, 200, Poison.encode!(todos))
  end

  post "/todos" do
    {:ok, body, conn} = read_body(conn)
    todo = Poison.decode!(body)
    id = :os.system_time(:millisecond)
    new_todo = Map.put(todo, "id", id)

    Agent.update(__MODULE__, fn state ->
      Map.put(state, id, new_todo)
    end)

    send_resp(conn, 201, Poison.encode!(new_todo))
  end

  delete "/todos/:id" do
    id = String.to_integer(id)

    Agent.update(__MODULE__, fn state ->
      Map.delete(state, id)
    end)

    send_resp(conn, 204, "")
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end

  defp read_body(conn) do
    {:ok, body, conn} = Plug.Conn.read_body(conn)
    {:ok, body, conn}
  end
end

