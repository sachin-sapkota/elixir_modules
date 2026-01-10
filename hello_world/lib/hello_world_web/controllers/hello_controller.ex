defmodule HelloWorldWeb.HelloController do
  use HelloWorldWeb, :controller

  def index(conn, _params) do
    text(conn, "hello world")
  end
end
