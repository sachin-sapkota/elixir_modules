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

  @doc """
  Gets user input and converts it to an integer.
  """
  def get_user_input do
    input = IO.gets("Enter your guess (1-100): ")
    case Integer.parse(String.trim(input)) do
      {number, _} -> number
      :error -> :error
    end
  end

  @doc """
  Compares the user's guess to the target number.
  """
  def compare_guess(guess, target) when guess == target do
    :correct
  end

  def compare_guess(guess, target) when guess > target do
    :too_high
  end

  def compare_guess(guess, target) when guess < target do
    :too_low
  end

  @doc """
  Starts the number guessing game.
  """
  def start_game do
    # Implementation will be added in subsequent steps
  end
end




