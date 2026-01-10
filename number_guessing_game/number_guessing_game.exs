defmodule NumberGuessingGame.Game do
  @moduledoc """
  A simple number guessing game.
  """

  @doc """
  Starts the number guessing game.
  """
  def start do
    target = Enum.random(1..100)
    IO.puts("Welcome to the Number Guessing Game!")
    IO.puts("I'm thinking of a number between 1 and 100.")
    play(target)
  end

  defp play(target) do
    guess = get_guess()
    
    cond do
      guess == target ->
        IO.puts("Congratulations! You guessed the number!")
      guess < target ->
        IO.puts("Too low! Try again.")
        play(target)
      guess > target ->
        IO.puts("Too high! Try again.")
        play(target)
    end
  end

  defp get_guess do
    input = IO.gets("Enter your guess: ")
    case Integer.parse(String.trim(input)) do
      {number, _} -> number
      :error -> 
        IO.puts("Please enter a valid number.")
        get_guess()
    end
  end
end

# Start the game when the script is run directly
if Code.ensure_loaded?(IEx) and IEx.started?() do
  # Don't automatically start the game in IEx
else
  NumberGuessingGame.Game.start()
end
