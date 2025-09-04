defmodule NumberGuessingGame do
  def start_game() do
    random_number = Enum.random(1..100)
    IO.puts("Welcome to the Number Guessing Game!")
    IO.puts("I'm thinking of a number between 1 and 100.")
    play_round(random_number)
  end

  defp play_round(random_number) do
    guess = get_guess()
    case check_guess(guess, random_number) do
      :correct ->
        IO.puts("Congratulations! You guessed the number.")
        if play_again() do
          start_game()
        else
          IO.puts("Thanks for playing!")
        end
      :too_high ->
        IO.puts("Too high! Try again.")
        play_round(random_number)
      :too_low ->
        IO.puts("Too low! Try again.")
        play_round(random_number)
    end
  end
end

