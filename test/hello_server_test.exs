defmodule HelloServerTest do
  use ExUnit.Case
  doctest HelloServer

  test "greets the world" do
    assert HelloServer.greeting() == "Hello, World!"
  end
end
