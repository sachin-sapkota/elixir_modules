import Config

config :todo,
  ecto_repos: []

config :todo, TodoWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: TodoWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Todo.PubSub,
  live_view: [signing_salt: "YOUR_SECRET_HERE"]

config :phoenix, :json_library, Jason

import_config "#{config_env()}.exs"
