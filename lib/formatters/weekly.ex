defmodule Repeatex.Formatter.Weekly do
  alias Repeatex.Repeat
  import String

  def format(%Repeat{} = repeat) do
    case repeat do
      %Repeat{type: type} when type != :weekly -> nil
      %Repeat{frequency: freq, days: days} ->
        days(days, Enum.count(days)) <> " " <> freq(freq)
      _ -> nil
    end
  end

  defp freq(1), do: "every week"
  defp freq(2), do: "every other week"
  defp freq(num) when is_integer(num) do
    "every #{num} weeks"
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

  defp days([day], _) when is_atom(day) do
    atom_to_day_string(day)
  end
  defp days([], _), do: ""

  defp atom_to_day_string(atom) do
    atom |> Atom.to_string |> capitalize
  end

end
