defmodule GuessingGame.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    IO.puts("Starting Guessing Game...")
    GuessingGame.start_game()
    Supervisor.start_link([], strategy: :one_for_one)
  end
end
