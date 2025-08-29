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
    {:ok, _pid} = HelloWorldServer.ClientHandler.start_link(client_socket)
    Process.send(self(), :accept, [])
    {:noreply, state}
  end
