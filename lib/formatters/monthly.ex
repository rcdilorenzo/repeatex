defmodule Repeatex.Formatter.Monthly do
  @behaviour Repeatex.Formatter
  import Repeatex.Helper, only: [all_days: 0]
  import String

  def format(repeat) do
    case repeat do
      %Repeatex{type: type} when type != :monthly -> nil
      %Repeatex{frequency: freq, days: days} when is_list(days) ->
        days(days, Enum.count(days)) <> " " <> freq(freq)
      %Repeatex{frequency: freq, days: days} when is_map(days) ->
        days(days) <> " " <> freq(freq)
      _ -> nil
    end
  end

  defp freq(1), do: "every month"
  defp freq(2), do: "every other month"
  defp freq(num) when is_integer(num) do
    "every #{num} months"
  end

  defp days(map) when is_map(map) do
    list = Enum.reduce(map, [], &(&2 ++ [&1]))
      |> Enum.sort_by(&day_sort_order/1)
    days(list, Enum.count(list))
  end

  defp days([day], _) do
    to_day_string(day)
  end

  defp days([day | [tail]], 2) do
    to_day_string(day) <> " and " <> to_day_string(tail)
  end

  defp days([day | [tail]], count) when count > 2 do
    to_day_string(day) <> ", and " <> to_day_string(tail)
  end

  defp days([day | tail], count) when is_list(tail) do
    to_day_string(day) <> ", " <> days(tail, count)
  end

  defp days([], _), do: ""

  def day_sort_order({day, week_number}) do
    day_index = Enum.find_index(all_days, &(&1 == day))
    week_number * 7 + day_index
  end

  defp to_day_string(num) when is_integer(num) do
    first_digit = to_string(num) |> split("", trim: true) |> List.last |> to_integer
    case first_digit do
      1 -> "#{num}st"
      2 -> "#{num}nd"
      3 -> "#{num}rd"
      _ -> "#{num}th"
    end
  end

  defp to_day_string({day, week_number}) when is_integer(week_number) and is_atom(day) do
    day = day |> Atom.to_string |> slice(0..2) |> capitalize
    "#{to_day_string(week_number)} #{day}"
  end

end
