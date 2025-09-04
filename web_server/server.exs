# Import the Plug module
Application.put_env(:logger, :level, :error)

# Start the Plug application on port 4000
Plug.Adapters.Cowboy.http(WebServer, [])
IO.puts("Server started on http://localhost:4000")
