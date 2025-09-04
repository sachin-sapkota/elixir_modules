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
  Game loop that continues until the user guesses the correct number.
  """
  def game_loop(target, attempts \\ 0) do
    guess = get_user_input()

    case guess do
      :error ->
        IO.puts("Invalid input. Please enter a number.")
        game_loop(target, attempts)

      _ ->
        attempts = attempts + 1

        case compare_guess(guess, target) do
          :correct ->
            IO.puts("Congratulations! You guessed the number in #{attempts} attempts.")
            :ok

          :too_high ->
            IO.puts("Too high! Try again.")
            game_loop(target, attempts)

          :too_low ->
            IO.puts("Too low! Try again.")
            game_loop(target, attempts)
        end
    end
  end

  @doc """
  Starts the number guessing game.
  """
  def start_game do
    IO.puts("Welcome to the Number Guessing Game!")
    IO.puts("I'm thinking of a number between 1 and 100.")
    target = generate_random_number()
    game_loop(target)
  end
end






