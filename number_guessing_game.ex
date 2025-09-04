defmodule NumberGuessingGame do
  @moduledoc """
  A simple number guessing game implemented in Elixir.
  """

  @doc """
  Generates a random secret number between 1 and the given maximum value.
  
  ## Parameters
  - max_value: The upper limit for the random number (inclusive)
  
  ## Returns
  - A random integer between 1 and max_value
  """
  def generate_secret_number(max_value) do
    Enum.random(1..max_value)
  end
end

