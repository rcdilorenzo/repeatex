defmodule Repeatex.Tokenizer.Yearly do
  @behaviour Repeatex.Tokenizer
  use Repeatex.Helper

  match_type :yearly, ~r/(year|annual)/

  match_freq 1, ~r/(yearly|annually)/
  match_freq 1, ~r/(each|every|of the).year/
  match_freq 2, ~r/bi-year(ly)?/
  match_freq 2, ~r/(each|every).other.year/
  match_freq "digit", ~r/(?<digit>\d+).year/

  def valid_days?(days) when is_map(days) do
    Map.keys(days) != [] and Enum.all?(days, fn {key, value} ->
      is_atom(key) and Enum.member?(months, key) and value >= 1 and value <= 31
    end)
  end
  def valid_days?(_), do: false

  def days(description) do
    days = ~r/(?<month>jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec)\w* (?<day>\d+)/i
      |> Regex.scan(description)
      |> Enum.reduce %{}, fn ([_, month, day], map) ->
        Map.put(map, find_month(month), String.to_integer(day))
      end
    if valid_days?(days), do: days
  end

end
