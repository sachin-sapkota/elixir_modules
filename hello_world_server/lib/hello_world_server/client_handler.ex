defmodule HelloWorldServer.ClientHandler do
  use GenServer

  def start_link(socket) do
    GenServer.start_link(__MODULE__, socket, [])
  end

  @impl true
  def init(socket) do
    :inet.setopts(socket, [:binary, packet: :line, active: true])
    {:ok, socket}
  end

  @impl true
  def handle_info({:tcp, _port, data}, socket) do
    :gen_tcp.send(socket, data)
    {:noreply, socket}
  end
end


