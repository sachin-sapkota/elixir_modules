# Import required modules
Application.put_env(:logger, :level, :error)

# Start the Plug application on port 4000
{:ok, _} = Plug.Cowboy.http(WebServer, [], port: 4000)
IO.puts("Server started on http://localhost:4000")

