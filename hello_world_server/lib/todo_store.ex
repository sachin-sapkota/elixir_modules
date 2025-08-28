defmodule HelloWorldServer.TodoStore do
  use Agent

  @doc """
  Starts the TodoStore Agent.
  """
  def start_link(_opts) do
    Agent.start_link(fn -> %{next_id: 1, todos: %{}} end, name: __MODULE__)
  end

  @doc """
  Returns all todos.
  """
  def all do
    Agent.get(__MODULE__, fn state -> Map.values(state.todos) end)
  end

  @doc """
  Returns a single todo by ID.
  """
  def get(id) do
    Agent.get(__MODULE__, fn state -> Map.get(state.todos, id) end)
  end

  @doc """
  Creates a new todo.
  """
  def create(title) do
    Agent.update(__MODULE__, fn state ->
      id = state.next_id
      todo = %{id: id, title: title, completed: false}
      %{state | next_id: id + 1, todos: Map.put(state.todos, id, todo)}
    end)
  end

  @doc """
  Updates an existing todo.
  """
  def update(id, attrs) do
    Agent.update(__MODULE__, fn state ->
      case Map.get(state.todos, id) do
        nil -> state
        todo ->
          updated_todo = Map.merge(todo, attrs)
          %{state | todos: Map.put(state.todos, id, updated_todo)}
      end
    end)
  end

