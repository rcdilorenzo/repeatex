defmodule Repeatex.Mixfile do
  use Mix.Project

  def project do
    [app: :repeatex,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps: deps]
  end

  def application do
    [applications: [:logger, :poison, :edate]]
  end

  defp deps do
    [
      {:amrita, "~> 0.4", github: "josephwilk/amrita"},
      {:edate, github: "dweldon/edate"},
      {:poison, "~> 1.3.1"},
      {:apex, "~> 0.3.2", only: :dev}
    ]
  end
end
