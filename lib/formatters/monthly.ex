defmodule Repeatex.Formatter.Monthly do
  @behaviour Repeatex.Formatter
  import String

  def format(repeat) do
    case repeat do
      %Repeatex{type: type} when type != :monthly -> nil
      %Repeatex{frequency: freq, days: days} ->
        days(days, Enum.count(days)) <> " " <> freq(freq)
      _ -> nil
    end
  end

  defp freq(1), do: "every month"
  defp freq(2), do: "every other month"
  defp freq(num) when is_integer(num) do
    "every #{num} months"
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

  defp to_day_string(num) when is_integer(num) do
    first_digit = to_string(num) |> split("", trim: true) |> List.last |> to_integer
    case first_digit do
      1 -> "#{num}st"
      2 -> "#{num}nd"
      3 -> "#{num}rd"
      _ -> "#{num}th"
    end
  end

  defp to_day_string({num, atom}) when is_integer(num) and is_atom(atom) do
    day = atom |> Atom.to_string |> slice(0..2) |> capitalize
    "#{to_day_string(num)} #{day}"
  end

end
