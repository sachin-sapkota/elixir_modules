defmodule Todo.Model do
  @moduledoc """
  Defines the data structure for a todo item.
  """

  @enforce_keys [:id, :title]
  defstruct [:id, :title, :completed]
end
