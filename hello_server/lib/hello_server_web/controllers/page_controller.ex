defmodule HelloServerWeb.PageController do
  use HelloServerWeb, :controller

  def hello(conn, _params) do
    send_resp(conn, 200, "world")
  end
end

