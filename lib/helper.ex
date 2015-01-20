defmodule Repeatex.Helper do

  @days [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]
  @days_index Enum.reduce(@days, %{}, fn (day, map) -> Map.put(map, day, Enum.find_index(@days, &(&1 == day))) end)

  def seq_days(start, end_day) when start in @days and end_day in @days do
    @days |> Enum.filter &in_day_range?(@days_index[&1], @days_index[start], @days_index[end_day])
  end

  defp in_day_range?(index, first_index, second_index) when first_index > second_index do
    (index >= first_index) or (index <= second_index)
  end
  defp in_day_range?(index, first_index, second_index) do
    (index >= first_index) and (index <= second_index)
  end

end
