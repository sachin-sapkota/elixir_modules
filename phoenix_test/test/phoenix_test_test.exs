defmodule PhoenixTestTest do
  use ExUnit.Case
  doctest PhoenixTest

  test "greets the world" do
    assert PhoenixTest.hello() == :world
  end
end
