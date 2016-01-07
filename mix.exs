defmodule Repeatex.Mixfile do
  use Mix.Project

  def project do
    [app: :repeatex,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger, :poison, :edate, :phoenix, :cowboy]]
  end

  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  defp deps do
    [
      {:phoenix, "~> 1.1.1", optional: true},
      {:amrita, "~> 0.4", github: "josephwilk/amrita"},
      {:edate, github: "dweldon/edate"},
      {:poison, "~> 1.3.1"},
      {:apex, "~> 0.3.2", only: :dev},
      {:cowboy, "~> 1.0"}
    ]
  end
end
