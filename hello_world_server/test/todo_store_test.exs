defmodule HelloWorldServer.TodoStoreTest do
  use ExUnit.Case
  use Plug.Test

  alias HelloWorldServer.TodoStore
  alias HelloWorldServer

  @json_headers [{"content-type", "application/json"}]

  setup do
    # Ensure the TodoStore is reset for each test
    {:ok, _pid} = Agent.start_link(fn -> %{next_id: 1, todos: %{}} end, name: TodoStore)
    :ok
  end

  test "GET /todos returns an empty list initially" do
    conn = conn(:get, "/todos")
    conn = HelloWorldServer.call(conn, [])
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "[]"
  end

  test "POST /todos creates a new todo" do
    conn = conn(:post, "/todos", %{"title" => "Buy groceries"})
    conn = put_req_headers(conn, @json_headers)
    conn = HelloWorldServer.call(conn, [])
    assert conn.state == :sent
    assert conn.status == 201
    assert conn.resp_body == "{\"message\":\"Todo created\"}"

    # Verify the todo was actually created
    todos = TodoStore.all()
    assert length(todos) == 1
    assert List.first(todos).title == "Buy groceries"
  end

  test "GET /todos returns a list of todos" do
    TodoStore.create("Walk the dog")
    TodoStore.create("Pay bills")

    conn = conn(:get, "/todos")
    conn = HelloWorldServer.call(conn, [])
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body |> Jason.decode!() |> length == 2
  end

  test "GET /todos/:id returns a single todo" do
    {:ok, _} = TodoStore.create("Read a book")
    todo = List.first(TodoStore.all())

    conn = conn(:get, "/todos/#{todo.id}")
    conn = HelloWorldServer.call(conn, [])
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body |> Jason.decode!() == todo
  end

  test "GET /todos/:id returns 404 for non-existent todo" do
    conn = conn(:get, "/todos/999")
    conn = HelloWorldServer.call(conn, [])
    assert conn.state == :sent
    assert conn.status == 404
    assert conn.resp_body == "{\"error\":\"Todo not found\"}"
  end

  test "PUT /todos/:id updates an existing todo" do
    {:ok, _} = TodoStore.create("Go to gym")
    todo = List.first(TodoStore.all())

    conn = conn(:put, "/todos/#{todo.id}", %{"completed" => true})
    conn = put_req_headers(conn, @json_headers)
    conn = HelloWorldServer.call(conn, [])
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "{\"message\":\"Todo updated\"}"

    updated_todo = TodoStore.get(todo.id)
    assert updated_todo.completed == true
  end

  test "PUT /todos/:id returns 404 for non-existent todo" do
    conn = conn(:put, "/todos/999", %{"completed" => true})
    conn = put_req_headers(conn, @json_headers)
    conn = HelloWorldServer.call(conn, [])
    assert conn.state == :sent
    assert conn.status == 404
    assert conn.resp_body == "{\"error\":\"Todo not found\"}"
  end

  test "DELETE /todos/:id deletes a todo" do
    {:ok, _} = TodoStore.create("Clean room")
    todo = List.first(TodoStore.all())

    conn = conn(:delete, "/todos/#{todo.id}")
    conn = HelloWorldServer.call(conn, [])
    assert conn.state == :sent
    assert conn.status == 204
    assert conn.resp_body == ""
