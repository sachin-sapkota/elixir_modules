defmodule HelloWorldWeb.Router do
  use HelloWorldWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", HelloWorldWeb do
    pipe_through :api

    get "/hello", HelloController, :index
  end
end
