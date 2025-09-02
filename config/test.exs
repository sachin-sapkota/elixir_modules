import Config

# Configure your database
config :hello_server, HelloServer.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "hello_server_test",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :hello_server, HelloServerWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "YOUR_SECRET_KEY_BASE_FOR_TEST",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
