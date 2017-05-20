defmodule Repeatex.Tokenizer.Monthly do
  @behaviour Repeatex.Tokenizer
  use Repeatex.Helper

  match_type :monthly, ~r/month(ly)?/i

  match_freq 2, ~r/bi-?month(ly)?/i
  match_freq 1, ~r/monthly/i
  match_freq 1, ~r/(each|every|of the).month/i
  match_freq 2, ~r/(each|every).other.month/i
  match_freq "digit", ~r/(?<digit>\d+).month/i

  @monthly_days ~r/(?<digit>\d+)(st|nd|rd|th).?((?<day>sun|mon|tues?|wedn?e?s?|thurs?|fri|satu?r?)($|day| ))?/i

  def days(description) do
    days = @monthly_days |> Regex.scan(description) |> Enum.map(fn
      ([_, digit, _]) -> String.to_integer digit
      ([_, digit, _, day_desc | _]) -> {find_day(day_desc), String.to_integer(digit)}
    end) |> sort_or_reduce_days
    if valid_days?(days), do: days
  end

  defp sort_or_reduce_days(days = [{_, _} | _]) do
    Enum.reduce(days, %{}, fn
      {key, value}, map -> Map.put(map, key, value)
      _, map -> map
    end)
  end

  defp sort_or_reduce_days(days) do
    Enum.sort(days) |> Enum.filter(&is_integer/1)
  end

  def valid_days?(days) do
    Enum.count(days) > 0 and Enum.all? days, fn
      ({_, week}) -> week <= 4
      (day) -> day > 0 and day <= 31
    end
  end

end
