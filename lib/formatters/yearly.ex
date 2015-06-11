defmodule Repeatex.Formatter.Yearly do
  alias Repeatex.Repeat
  import String

  def format(%Repeat{} = repeat) do
    case repeat do
      %Repeat{type: type} when type != :yearly -> nil
      %Repeat{frequency: freq, days: days} ->
        days(days, Enum.count(days)) <> " " <> freq(freq)
      _ -> nil
    end
  end

  defp freq(1), do: "every year"
  defp freq(2), do: "every other year"
  defp freq(num) when is_integer(num) do
    "every #{num} weeks"
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
