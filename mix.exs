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
      {:poison, "~> 1.3.1", optional: true},
      {:cowboy, "~> 1.0", optional: true},
      {:edate, github: "dweldon/edate"},
      {:apex, "~> 0.3.2", only: :dev},
      {:amrita, "~> 0.4", github: "josephwilk/amrita", only: :test}
    ]
  end
end
