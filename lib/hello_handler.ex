defmodule HelloHandler do
  @moduledoc """
  Handles the GET request for /hello and responds with "hello sachin".
  """

  def init(req, state) do
    {:ok, req, state}
  end

  def handle(req, state) do
    response = "hello sachin"
    headers = [{"content-type", "text/plain"}]
    req = :cowboy_req.reply(200, headers, response, req)
    {:ok, req, state}
  end

  def terminate(_reason, _req, _state) do
    :ok
  end
end
