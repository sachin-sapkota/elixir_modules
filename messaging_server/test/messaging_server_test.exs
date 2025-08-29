defmodule MessagingServerTest do
  use ExUnit.Case
  doctest MessagingServer

  test "greets the world" do
    assert MessagingServer.hello() == :world
  end
end
