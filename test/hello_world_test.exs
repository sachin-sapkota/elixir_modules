defmodule HelloWorldTest do
  use ExUnit.Case
  doctest HelloWorld

  test "prints hello world" do
    assert HelloWorld.hello() == :ok
  end
end

