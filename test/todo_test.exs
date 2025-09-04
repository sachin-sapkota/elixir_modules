defmodule TodoTest do
  use ExUnit.Case
  doctest Todo

  alias Todo.Model

  describe "create_todo/1" do
    test "returns the input todo item" do
      todo_item = %Model{id: 1, title: "Test todo"}
      assert Todo.create_todo(todo_item) == todo_item
    end
  end

  describe "delete_todo/1" do
    test "returns the input todo id" do
      todo_id = 1
      assert Todo.delete_todo(todo_id) == todo_id
    end
  end
end
