defmodule NumberGuessingGameTest do
  use ExUnit.Case
  doctest NumberGuessingGame

  test "greets the world" do
    assert NumberGuessingGame.hello() == :world
  end
end
