defmodule NumberGuessingGame do
  def start_game() do
    random_number = Enum.random(1..100)
    IO.puts("Welcome to the Number Guessing Game!")
    IO.puts("I'm thinking of a number between 1 and 100.")
    play_round(random_number)
  end

  def get_guess() do
    IO.puts("Enter your guess:")
    input = IO.gets(">")
    case Integer.parse(String.trim(input)) do
      {number, _} -> number
      :error -> 
        IO.puts("Invalid input. Please enter a number.")
        get_guess()
    end
  end

  def check_guess(guess, target) when guess == target, do: :correct
  def check_guess(guess, target) when guess > target, do: :too_high
  def check_guess(guess, target) when guess < target, do: :too_low

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



