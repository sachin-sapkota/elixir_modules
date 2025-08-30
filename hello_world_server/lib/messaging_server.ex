defmodule MessagingServer do
  use Plug.Router
  use Plug.ErrorHandler

  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], json_decoder: Jason)
  plug(:dispatch)

  def start_link(port) do
    {:ok, _} = Plug.Cowboy.http(__MODULE__, [], port: port)
    start_messages_agent()
  end

  defp start_messages_agent do
    Agent.start_link(fn -> [] end, name: __MODULE__.Messages)
  end

  get /messages do
    messages = Agent.get(__MODULE__.Messages, & &1)
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(messages))
  end

  post /messages do
    message = conn.body_params["message"]
    Agent.update(__MODULE__.Messages, &[message | &1])
    send_resp(conn, 201, "Message added")
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end
end
