defmodule HelloServer do
  @moduledoc """
  A simple web server using Cowboy that responds with "hello sachin" to a GET request at `/hello`.
  """

  require Logger

  def start_link(_opts) do
    dispatch = :cowboy_router.compile([
      {:_, [
        {"/hello", HelloHandler, []}
      ]}
    ])

    {:ok, _} = :cowboy.start_clear(__MODULE__, [port: 8080], %{
      env: %{dispatch: dispatch}
    })
  end

  def stop do
    :cowboy.stop_listener(__MODULE__)
  end
end
