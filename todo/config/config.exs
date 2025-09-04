import Config

config :todo,
  ecto_repos: []

config :todo, TodoWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: TodoWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Todo.PubSub,
  live_view: [signing_salt: "YOUR_SECRET_HERE"]

config :phoenix, :json_library, Jason

# Configures the endpoint
config :todo, TodoWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    view: TodoWeb.ErrorView,
    accepts: ~w(html json),
    layout: false
  ],
  pubsub_server: Todo.PubSub,
  live_view: [signing_salt: "YOUR_SECRET_HERE"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

import_config "#{config_env()}.exs"

