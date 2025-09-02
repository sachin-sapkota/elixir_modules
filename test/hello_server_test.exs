defmodule HelloServerTest do
  use ExUnit.Case
  use Plug.Test
  doctest HelloServer

  test "greets the world" do
    assert HelloServer.greeting() == "Hello, World!"
  end

  test "returns JSON response" do
    conn = HelloServer.call(conn(:get, "/json"), [])
    assert conn.status == 200
    assert conn.resp_body == "{\"message\": \"Hello, World!\"}"
    assert conn.resp_headers == [{"content-type", "application/json"}]
  end
end

