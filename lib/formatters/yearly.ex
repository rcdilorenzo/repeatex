defmodule Repeatex.Formatter.Yearly do
  @behaviour Repeatex.Formatter
  import String
  import Repeatex.Helper

  def format(repeat) do
    case repeat do
      %Repeatex{type: type} when type != :yearly -> nil
      %Repeatex{frequency: freq, days: days} ->
        days(days) <> " " <> freq(freq)
      _ -> nil
    end
  end

  defp freq(1), do: "every year"
  defp freq(2), do: "every other year"
  defp freq(num) when is_integer(num) do
    "every #{num} weeks"
  end

  defp days(map) when is_map(map) do
    list = Enum.reduce(map, [], &(&2 ++ [&1]))
      |> Enum.sort_by(&day_sort_order/1)
    days(list, Enum.count(list))
  end

  defp days([day | [tail]], 2) do
    to_day_string(day) <> " and " <> to_day_string(tail)
  end

  defp days([day | [tail]], count) when count > 2 do
    to_day_string(day) <> ", and " <> to_day_string(tail)
  end

  defp days([day], _) when is_tuple(day) do
    to_day_string(day)
  end

  defp days([day | tail], count) when is_list(tail) do
    to_day_string(day) <> ", " <> days(tail, count)
  end

  defp days([], _), do: ""

  def day_sort_order({month, day}) do
    month_index = Enum.find_index(months, &(&1 == month))
    month_index * 31 + day
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

  defp to_day_string({atom, num}) when is_integer(num) and is_atom(atom) do
    month = atom |> Atom.to_string |> slice(0..2) |> capitalize
    "#{month} #{to_day_string(num)}"
  end

end
