defmodule WebServer do
  require Logger

  def start(port) do
    :gen_tcp.listen(port, [:binary, active: false, reuseaddr: true])
    |> listen(port)
  end

  defp listen({:ok, socket}, port) do
    Logger.info("Listening for connections on port #{port}")
    loop_accept(socket, port)
  end

  defp listen({:error, reason}, port) do
    Logger.error("Failed to listen on port #{port}: #{reason}")
  end

  defp loop_accept(socket, port) do
    case :gen_tcp.accept(socket) do
      {:ok, client_socket} ->
        Task.start(fn -> handle_client(client_socket) end)
        loop_accept(socket, port)

      {:error, reason} ->
        Logger.error("Accept failed: #{reason}")
    end
  end

  defp handle_client(socket) do
    {:ok, request} = :gen_tcp.recv(socket, 0)
    Logger.info("Received request: #{request}")

    response = "HTTP/1.1 200 OK\r\nContent-Length: 12\r\n\r\nHello World!"
    :gen_tcp.send(socket, response)
    :gen_tcp.close(socket)
  end
end

WebServer.start(8080)
