defmodule Counter do
  def init() do
    0
  end

  def increment(count) do
    count + 1
  end

  def get(count) do
    count
