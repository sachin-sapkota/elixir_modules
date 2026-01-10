defmodule GuessingGame do
  def start do
    secret_number = Enum.random(1..100)
    IO.puts("Welcome to the Guessing Game!")
    IO.puts("I'm thinking of a number between 1 and 100.")
    guess(secret_number)
  end

  defp guess(secret_number) do
    input = IO.gets("Enter your guess: ")
    
    case Integer.parse(input) do
      {guess_number, _} ->
        case compare(guess_number, secret_number) do
          :correct ->
            IO.puts("Congratulations! You guessed the number!")
          :too_high ->
            IO.puts("Too high! Try again.")
            guess(secret_number)
          :too_low ->
            IO.puts("Too low! Try again.")
            guess(secret_number)
        end
      :error ->
        IO.puts("Please enter a valid number.")
        guess(secret_number)
    end
  end

  defp compare(guess, secret) when guess == secret, do: :correct
  defp compare(guess, secret) when guess > secret, do: :too_high
  defp compare(guess, secret) when guess < secret, do: :too_low
end

GuessingGame.start()
