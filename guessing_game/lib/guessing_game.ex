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
    guess = IO.gets("Enter your guess (1-100): ")
    
    # Handle EOF case
    if guess == :eof do
      IO.puts("Exiting game...")
      System.halt(0)
    end
    
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
    {:continue, "Too low!"}
  end

  def compare_guess(guess, target) when guess > target do
    {:continue, "Too high!"}
  end

  def compare_guess(guess, target) when guess == target do
    {:win, "Correct! You guessed the number!"}
  end

  @doc """
  Main game loop that continues until the user guesses the correct number.
  """
  def game_loop(secret_number) do
    guess = get_user_guess()
    case compare_guess(guess, secret_number) do
      {:continue, message} -> 
        IO.puts(message)
        game_loop(secret_number)
      {:win, message} -> 
        IO.puts(message)
        IO.puts("You win!")
    end
  end

  @doc """
  Starts the game and calls the game loop.
  """
  def start do
    IO.puts("Welcome to the Number Guessing Game!")
    IO.puts("I'm thinking of a number between 1 and 100.")
    secret_number = generate_random_number()
    game_loop(secret_number)
  end
end

# Call the start function to begin the game when the module is run
GuessingGame.start()










