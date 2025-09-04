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

  @doc """
  Runs the main game loop.
  """
  def play_game(min \\ 1, max \\ 100) do
    target = generate_random_number(min, max)
    play_game_loop(target, 0)
  end

  defp play_game_loop(target, attempts) do
    guess = get_guess()
    attempts = attempts + 1

    case play_round(target, guess) do
      :correct ->
        IO.puts("Congratulations! You guessed the number in #{attempts} attempts.")
        attempts

      :too_high ->
        IO.puts("Too high!")
        play_game_loop(target, attempts)

      :too_low ->
        IO.puts("Too low!")
        play_game_loop(target, attempts)
    end
  end

  defp get_guess() do
    input = IO.gets("Enter your guess: ")
    case Integer.parse(String.trim(input)) do
      {number, _} -> number
      :error -> 
        IO.puts("Invalid input. Please enter a number.")
        get_guess()
    end
  end
end

