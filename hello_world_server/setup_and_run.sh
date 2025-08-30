#!/bin/bash

# Install Erlang and Elixir
sudo apt update -y && sudo apt install erlang elixir -y

# Start the server
mix run --no-halt
