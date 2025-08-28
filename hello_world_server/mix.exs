defmodule HelloWorldServer.MixProject do
  use Mix.Project

  def project do
    [
      app: :hello_world_server,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {HelloWorldServer.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug, "~> 1.18"},
      {:plug_cowboy, "~> 2.7"}
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:poison, "~> 4.0"}
    ]
  end
end

