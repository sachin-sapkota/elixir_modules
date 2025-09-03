defmodule HelloServerWeb.PageController do
  use HelloServerWeb, :controller

  alias HelloServer.Hello
  alias HelloServer.Hello.Page

  def index(conn, _params) do
    pages = Hello.list_pages()
    render(conn, :index, pages: pages)
  end

  def new(conn, _params) do
    changeset = Hello.change_page(%Page{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"page" => page_params}) do
    case Hello.create_page(page_params) do
      {:ok, page} ->
        conn
        |> put_flash(:info, "Page created successfully.")
        |> redirect(to: ~p"/pages/#{page}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    page = Hello.get_page!(id)
    render(conn, :show, page: page)
  end

  def edit(conn, %{"id" => id}) do
    page = Hello.get_page!(id)
    changeset = Hello.change_page(page)
    render(conn, :edit, page: page, changeset: changeset)
  end

  def update(conn, %{"id" => id, "page" => page_params}) do
    page = Hello.get_page!(id)

    case Hello.update_page(page, page_params) do
      {:ok, page} ->
        conn
        |> put_flash(:info, "Page updated successfully.")
        |> redirect(to: ~p"/pages/#{page}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, page: page, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    page = Hello.get_page!(id)
    {:ok, _page} = Hello.delete_page(page)

    conn
    |> put_flash(:info, "Page deleted successfully.")
    |> redirect(to: ~p"/pages")
  end
end
