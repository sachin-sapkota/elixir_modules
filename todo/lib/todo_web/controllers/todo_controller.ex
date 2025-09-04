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
    changeset = Todo.change_todo(%Todo.Todo{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"todo" => todo_params}) do
    case Todo.create_todo(todo_params) do
      {:ok, todo} ->
        conn
        |> put_flash(:info, "Todo created successfully.")
        |> redirect(to: Routes.todo_path(conn, :show, todo))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    todo = Todo.get_todo!(id)
    changeset = Todo.change_todo(todo)
    render(conn, "edit.html", todo: todo, changeset: changeset)
  end

  def update(conn, %{"id" => id, "todo" => todo_params}) do
    todo = Todo.get_todo!(id)

    case Todo.update_todo(todo, todo_params) do
      {:ok, todo} ->
        conn
        |> put_flash(:info, "Todo updated successfully.")
        |> redirect(to: Routes.todo_path(conn, :show, todo))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", todo: todo, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo = Todo.get_todo!(id)
    {:ok, _todo} = Todo.delete_todo(todo)

    conn
    |> put_flash(:info, "Todo deleted successfully.")
    |> redirect(to: Routes.todo_path(conn, :index))
  end
end
