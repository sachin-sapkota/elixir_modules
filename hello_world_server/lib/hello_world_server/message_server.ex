defmodule HelloWorldServer.MessageServer do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @impl true
  def init(:ok) do
    port = 4040
    {:ok, listen_socket} = :gen_tcp.listen(port, [:binary, packet: :line, active: false, reuseaddr: true])
    IO.puts("Server listening on port #{port}")
    Process.send(self(), :accept, [])
    {:ok, %{listen_socket: listen_socket, port: port}}
  end

  @impl true
  def handle_info(:accept, state) do
    {:ok, client_socket} = :gen_tcp.accept(state.listen_socket)
    # The ClientHandler will be created in a separate file in the next step.
    Task.start(fn -> :gen_tcp.close(client_socket) end)
    Process.send(self(), :accept, [])
    {:noreply, state}
  end
