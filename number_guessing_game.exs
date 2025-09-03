# Number Guessing Game

defmodule NumberGuessingGame do
  def start do
    IO.puts("Welcome to the Number Guessing Game!")
    IO.puts("I'm thinking of a number between 1 and 100.")
    play_game()
  end

  defp play_game do
    secret_number = Enum.random(1..100)
    guess_loop(secret_number)
  end

  defp guess_loop(secret_number) do
    guess = get_guess()
    case compare_guess(guess, secret_number) do
      :correct ->
        IO.puts("Congratulations! You guessed the number!")
        play_again?()
      :too_low ->
        IO.puts("Too low! Try again.")
        guess_loop(secret_number)
      :too_high ->
        IO.puts("Too high! Try again.")
        guess_loop(secret_number)
    end
  end

  defp get_guess do
    input = IO.gets("Enter your guess: ")
    case input do
      :eof ->
        IO.puts("No input received. Exiting game.")
        exit(:normal)
      _ ->
        case Integer.parse(String.trim(input)) do
          {number, _} -> number
          :error ->
            IO.puts("Please enter a valid number.")
            get_guess()
        end
    end
  end

  defp compare_guess(guess, secret_number) when guess == secret_number, do: :correct
  defp compare_guess(guess, secret_number) when guess < secret_number, do: :too_low
  defp compare_guess(guess, secret_number) when guess > secret_number, do: :too_high

  defp play_again? do
    input = IO.gets("Would you like to play again? (y/n): ")
    case input do
      :eof ->
        IO.puts("Thanks for playing!")
        exit(:normal)
      _ ->
        case String.trim(input) do
          "y" -> start()
          "n" -> IO.puts("Thanks for playing!")
          _ ->
            IO.puts("Please enter 'y' or 'n'.")
            play_again?()
        end
    end
  end
end

NumberGuessingGame.start()


