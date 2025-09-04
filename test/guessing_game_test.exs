defmodule GuessingGameTest do
  use ExUnit.Case
  doctest GuessingGame

  describe "generate_random_number/2" do
    test "generates a number within the specified range" do
      min = 1
      max = 10
      result = GuessingGame.generate_random_number(min, max)
      assert result >= min and result <= max
    end
  end

  describe "compare_guess/2" do
    test "returns :correct when guess matches target" do
      assert GuessingGame.compare_guess(5, 5) == :correct
    end

    test "returns :too_high when guess is greater than target" do
      assert GuessingGame.compare_guess(10, 5) == :too_high
    end

    test "returns :too_low when guess is less than target" do
      assert GuessingGame.compare_guess(3, 5) == :too_low
    end
  end

  describe "get_range_for_difficulty/1" do
    test "returns correct range for :easy" do
      assert GuessingGame.get_range_for_difficulty(:easy) == {1, 50}
    end

    test "returns correct range for :medium" do
      assert GuessingGame.get_range_for_difficulty(:medium) == {1, 100}
    end

    test "returns correct range for :hard" do
      assert GuessingGame.get_range_for_difficulty(:hard) == {1, 200}
    end

    test "returns default range for unknown difficulty" do
      assert GuessingGame.get_range_for_difficulty(:unknown) == {1, 100}
    end
  end
end
