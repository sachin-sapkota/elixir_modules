defmodule GuessingGame do
  @moduledoc """
  A simple guessing game where the user tries to guess a randomly generated number.
  """

  @doc """
  Starts the guessing game.
  """
  def start do
    secret_number = Enum.random(1..100)
    play(secret_number)
  end

  defp play(secret_number) do
    guess = get_guess()
    case check_guess(guess, secret_number) do
      :correct ->
        IO.puts("Congratulations! You guessed the number #{secret_number} correctly!")
      :too_high ->
        IO.puts("Too high! Try again.")
        play(secret_number)
      :too_low ->
        IO.puts("Too low! Try again.")
        play(secret_number)
    end
  end

  defp get_guess do
    input = IO.gets("Guess a number between 1 and 100: ")
    case Integer.parse(input) do
      {number, _} -> number
      :error -> 
        IO.puts("Please enter a valid number.")
        get_guess()
    end
  end

  defp check_guess(guess, secret_number) when guess == secret_number, do: :correct
  defp check_guess(guess, secret_number) when guess > secret_number, do: :too_high
  defp check_guess(guess, secret_number) when guess < secret_number, do: :too_low
end

