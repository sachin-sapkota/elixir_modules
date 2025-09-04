defmodule GuessingGame do
  @moduledoc """
  A simple number guessing game.
  """

  @doc """
  Generates a random number between 1 and 100.
  """
  def generate_random_number do
    Enum.random(1..100)
  end

  def get_user_guess do
    guess = IO.gets("Enter your guess (1-100): ")
    case Integer.parse(String.trim(guess)) do
      {num, _} when num >= 1 and num <= 100 -> num
      _ ->
        IO.puts("Invalid input. Please enter a number between 1 and 100.")
        get_user_guess()
    end
  end

  @doc """
  Compares the user's guess to the random number and provides feedback.
  """
  def compare_guess(guess, target) when guess < target do
    IO.puts("Too low!")
    :continue
  end

  def compare_guess(guess, target) when guess > target do
    IO.puts("Too high!")
    :continue
  end

  def compare_guess(guess, target) when guess == target do
    IO.puts("Correct! You guessed the number!")
    :win
  end

  @doc """
  Gets user input for their guess.
  """
  def get_user_guess do
    IO.gets("Enter your guess (1-100): ")
    |> String.trim()
    |> Integer.parse()
  end
end




