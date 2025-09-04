defmodule HelloWeb.Handler do
  def init(req, opts) do
    {:ok, req, opts}
  end

  def handle(req, state) do
    {:ok, req} = :cowboy_req.reply(200, %{"content-type" => "text/plain"}, "Hello, world!", req)
    {:ok, req, state}
  end
end
