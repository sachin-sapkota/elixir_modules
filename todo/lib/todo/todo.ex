defmodule Todo.Todo do
  @moduledoc """
  A struct representing a Todo item.
  """

  @enforce_keys [:id, :title]
  defstruct [:id, :title, :completed]

  @doc """
  Creates a new Todo struct.
  """
  def new(id, title, completed \\ false) do
    %__MODULE__{id: id, title: title, completed: completed}
  end
end

