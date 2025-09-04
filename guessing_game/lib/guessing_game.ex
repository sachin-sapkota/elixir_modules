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
  Gets user input for their guess.
  """
  def get_user_guess do
    IO.gets("Enter your guess (1-100): ")
    |> String.trim()
    |> Integer.parse()
  end
end


