defmodule TodoCLI do
  @moduledoc """
  A simple command-line interface for the Todo module.
  """

  alias Todo

  def main(_args) do
    todo_list = Todo.new()
    run(todo_list)
  end

  defp run(todo_list) do
    IO.puts("\\n===== Todo List =====")
    IO.puts("1. Add task")
    IO.puts("2. List tasks")
    IO.puts("3. Remove task")
    IO.puts("4. Exit")
    IO.write("Choose an option: ")

    case IO.gets("") do
      :eof ->
        IO.puts("\\nGoodbye!")
      input ->
        case input |> String.trim() |> String.to_integer() do
          {:ok, 1} ->
            add_task(todo_list)
          {:ok, 2} ->
            list_tasks(todo_list)
          {:ok, 3} ->
            remove_task(todo_list)
          {:ok, 4} ->
            IO.puts("Goodbye!")
          _ ->
            IO.puts("Invalid option. Please try again.")
            run(todo_list)
        end
    end
  end

  defp add_task(todo_list) do
    IO.write("Enter a task: ")
    task = IO.gets("") |> String.trim()
    new_list = Todo.add(todo_list, task)
    IO.puts("Task added!")
    run(new_list)
  end

  defp list_tasks(todo_list) do
    tasks = Todo.list(todo_list)
    if Enum.empty?(tasks) do
      IO.puts("No tasks in the list.")
    else
      IO.puts("Tasks:")
      tasks
      |> Enum.with_index(1)
      |> Enum.each(fn {task, index} ->
        IO.puts("#{index}. #{task}")
      end)
    end
    run(todo_list)
  end

  defp remove_task(todo_list) do
    tasks = Todo.list(todo_list)
    if Enum.empty?(tasks) do
      IO.puts("No tasks to remove.")
      run(todo_list)
    else
      list_tasks(todo_list)
      IO.write("Enter the number of the task to remove: ")
      case IO.gets("") |> String.trim() |> String.to_integer() do
        {:ok, index} ->
          case Todo.remove(todo_list, index) do
            {removed_task, new_list} ->
              IO.puts("Removed task: #{removed_task}")
              run(new_list)
            {:error, reason} ->
              IO.puts(reason)
              run(todo_list)
          end
        :error ->
          IO.puts("Invalid input. Please enter a number.")
          remove_task(todo_list)
      end
    end
  end
end

