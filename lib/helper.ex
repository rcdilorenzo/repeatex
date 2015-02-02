defmodule Repeatex.Helper do

  @day_patterns %{
    sunday: ~r/sun(day)?/,
    monday: ~r/mon(day)?/,
    tuesday: ~r/tues?(day)?/,
    wednesday: ~r/wedn?e?s?(day)?/,
    thursday: ~r/thurs?(day)?/,
    friday: ~r/fri(day)?/,
    saturday: ~r/satu?r?(day)?/,
  }

  @days [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]
  @days_index Enum.reduce(@days, %{}, fn (day, map) -> Map.put(map, day, Enum.find_index(@days, &(&1 == day))) end)

  def seq_days(start, end_day) when start in @days and end_day in @days do
    @days |> Enum.filter &in_day_range?(@days_index[&1], @days_index[start], @days_index[end_day])
  end

  def find_day(description) do
    find_days(description) |> List.first
  end

  def find_days(description) do
    @day_patterns |> Enum.filter_map fn ({_, regex}) ->
      Regex.match? regex, description
    end, (fn ({atom, _}) -> atom end)
  end



  defp in_day_range?(index, first_index, second_index) when first_index > second_index do
    (index >= first_index) or (index <= second_index)
  end
  defp in_day_range?(index, first_index, second_index) do
    (index >= first_index) and (index <= second_index)
  end

end
