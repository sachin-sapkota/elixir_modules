import Config

# Configuration for the Plug.Cowboy server
config :elixir_modules,
  http_port: 4000

# Import environment specific config
import_config "#{config_env()}.exs"


