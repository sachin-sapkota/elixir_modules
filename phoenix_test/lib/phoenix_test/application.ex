defmodule PhoenixTest.Application do
  use Application
  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: PhoenixTest.Plug, options: [port: 4000]}
    ]
    opts = [strategy: :one_for_one, name: PhoenixTest.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
