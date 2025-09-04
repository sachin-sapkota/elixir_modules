defmodule Todo do
  @moduledoc """
  A simple module to manage a todo list.
  """

  @doc """
  Creates a new empty todo list.
  """
  def new do
    []
  end

  @doc """
  Adds a task to the todo list.
  """
  def add(todo_list, task) do
    [task | todo_list]
  end

  @doc """
  Lists all tasks in the todo list.
  """
  def list(todo_list) do
    Enum.reverse(todo_list)
  end

  @doc """
  Removes a task from the todo list by its index (1-based).
  """
  def remove(todo_list, index) when index > 0 and index <= length(todo_list) do
    {removed, remaining} = List.pop_at(Enum.reverse(todo_list), index - 1)
    {removed, Enum.reverse(remaining)}
  end

  def remove(todo_list, _index) do
    {:error, "Invalid index"}
  end
end
