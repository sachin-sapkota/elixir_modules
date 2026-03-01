defmodule TodoWeb.TodoController do
  use TodoWeb, :controller

  def index(conn, _params) do
    todos = Todo.list_todos()
    render(conn, "index.html", todos: todos)
  end

  def show(conn, %{"id" => id}) do
    todo = Todo.get_todo!(id)
    render(conn, "show.html", todo: todo)
  end

  def new(conn, _params) do
    # Create a blank todo struct for the form
    todo = %Todo.Todo{id: nil, title: "", completed: false}
    render(conn, "new.html", todo: todo)
  end

  def create(conn, %{"todo" => todo_params}) do
    # Generate a simple ID (in a real app, you might use UUID or database ID)
    id = :erlang.unique_integer([:positive, :monotonic])
    
    case Todo.create_todo(todo_params) do
      {:ok, todo} ->
        conn
        |> put_flash(:info, "Todo created successfully.")
        |> redirect(to: Routes.todo_path(conn, :show, todo))

      {:error, reason} ->
        # Create a todo struct with the submitted data for the form
        todo = %Todo.Todo{
          id: id,
          title: todo_params["title"] || "",
          completed: todo_params["completed"] == "true"
        }
        render(conn, "new.html", todo: todo)
    end
  end

  def edit(conn, %{"id" => id}) do
    todo = Todo.get_todo!(id)
    render(conn, "edit.html", todo: todo)
  end

  def update(conn, %{"id" => id, "todo" => todo_params}) do
    case Todo.update_todo(id, todo_params) do
      {:ok, todo} ->
        conn
        |> put_flash(:info, "Todo updated successfully.")
        |> redirect(to: Routes.todo_path(conn, :show, todo))

      {:error, reason} ->
        # Get the existing todo for the form
        todo = Todo.get_todo!(id)
        render(conn, "edit.html", todo: todo)
    end
  end

  def delete(conn, %{"id" => id}) do
    {:ok, _todo} = Todo.delete_todo(id)

    conn
    |> put_flash(:info, "Todo deleted successfully.")
    |> redirect(to: Routes.todo_path(conn, :index))
  end
end

