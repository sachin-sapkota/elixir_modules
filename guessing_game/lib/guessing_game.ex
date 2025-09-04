defmodule GuessingGame do
  @moduledoc """
  Documentation for `GuessingGame`.
  """

  @doc """
  Starts the number guessing game.
  """
  def start_game do
    secret_number = Enum.random(1..100)
    IO.puts("Welcome to the Number Guessing Game!")
    IO.puts("I'm thinking of a number between 1 and 100.")
    play_round(secret_number)
  end

  defp play_round(secret_number) do
    guess = get_guess()
    
    cond do
      guess < secret_number ->
        IO.puts("Too low! Try again.")
        play_round(secret_number)
      guess > secret_number ->
        IO.puts("Too high! Try again.")
        play_round(secret_number)
      guess == secret_number ->
        IO.puts("Congratulations! You guessed the number!")
    end
  end

  defp get_guess do
    input = IO.gets("Enter your guess: ")
    case Integer.parse(String.trim(input)) do
      {number, _} -> number
      :error -> 
        IO.puts("Invalid input. Please enter a number.")
        get_guess()
    end
  end
end

