defmodule Repeatex.Repeat do
  defstruct type: :unknown, frequency: 0, days: []

  def all_days, do: [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]
end
