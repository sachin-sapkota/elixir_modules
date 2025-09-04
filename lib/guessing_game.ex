defmodule GuessingGame do
  @moduledoc """
  A simple number guessing game.
  """

  @doc """
  Generates a random number within a specified range.
  """
  def generate_random_number(min, max) do
    Enum.random(min..max)
  end

  @doc """
  Compares a guess to the target number.
  Returns :correct, :too_high, or :too_low.
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
  Plays a single round of the guessing game.
  """
  def play_round(target, guess) do
    compare_guess(guess, target)
  end
end
