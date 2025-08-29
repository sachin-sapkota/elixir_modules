defmodule HelloWorldServer.PlugTest do
  use ExUnit.Case
  use Plug.Test

  @moduletag :plug

  alias HelloWorldServer.Plug

  test "GET / returns 'Hello from GET!'" do
    conn = conn(:get, "/")
    conn = Plug.call(conn, Plug.init([]))
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "Hello from GET!"
  end

  test "POST / with name=John returns 'Hello, John!'" do
    conn = conn(:post, "/", "name=John")
    conn = Plug.call(conn, Plug.init([]))
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "Hello, John!"
  end

  test "POST / without name returns 'Hello, stranger!'" do
    conn = conn(:post, "/")
    conn = Plug.call(conn, Plug.init([]))
    assert conn.state == :sent
