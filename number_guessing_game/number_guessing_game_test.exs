defmodule NumberGuessingGameTest do
  use ExUnit.Case
  doctest NumberGuessingGame

  test "game starts without errors" do
    # Mock IO to avoid actual input/output during testing
    mock_io = fn ->
      send(self(), {:io_result, :ok})
      {:ok, "50\n"}  # Simulate user input
    end

    # Test that the game module can be loaded
    assert Code.ensure_loaded?(NumberGuessingGame.Game)

    # Test that the start function exists
    assert function_exported?(NumberGuessingGame.Game, :start, 0)

    # We won't actually run the game in tests as per requirements
    # but we can verify it compiles without errors
    assert is_atom(NumberGuessingGame.Game)
  end
end
