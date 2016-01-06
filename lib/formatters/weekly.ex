defmodule Repeatex.Formatter.Weekly do
  @behaviour Repeatex.Formatter
  import String

  def format(repeat) do
    case repeat do
      %Repeatex{type: type} when type != :weekly -> nil
      %Repeatex{frequency: freq, days: days} ->
        freq(freq) <> " on " <> days(days, Enum.count(days))
      _ -> nil
    end
  end

  defp freq(1), do: "Every week"
  defp freq(2), do: "Every other week"
  defp freq(num) when is_integer(num) do
    "Every #{num} weeks"
  end

  defp days([day], _) when is_atom(day) do
    atom_to_day_string(day)
  end

  defp days([day | [tail]], 2) do
    atom_to_day_string(day) <> " and " <> atom_to_day_string(tail)
  end

  defp days([day | [tail]], count) when count > 2 do
    atom_to_day_string(day) <> ", and " <> atom_to_day_string(tail)
  end

  defp days([day | tail], count) when is_list(tail) do
    atom_to_day_string(day) <> ", " <> days(tail, count)
  end

  defp days([], _), do: ""

  defp atom_to_day_string(atom) do
    atom |> Atom.to_string |> slice(0..2) |> capitalize
  end

end
