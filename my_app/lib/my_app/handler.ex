defmodule MyApp.Handler do
  def init(request, state) do
    IO.inspect(request, label: "Received request")
    {:ok, state}
  end

  def handle(request, state) do
    response = "Hello from the handler!"
    {:ok, response} = Plug.Conn.send_resp(request, 200, response)
    {:ok, response, state}
  end
end
