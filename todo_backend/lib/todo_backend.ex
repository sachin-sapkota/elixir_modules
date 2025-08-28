defmodule TodoBackend do
  @moduledoc """
  A simple todo backend server using Plug and Cowboy.
  """

  use Plug.Router
  require Logger

  plug :match
  plug :dispatch

  # Define a simple route for now
  get "/" do
    send_resp(conn, 200, "Hello from TodoBackend!")
  end

  def start(_type, _args) do
    Plug.Cowboy.start_link(scheme: :http, plug: __MODULE__, options: [port: 4000])
  end
end

