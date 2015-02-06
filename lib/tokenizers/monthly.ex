defmodule Repeatex.Tokenizer.Monthly do
  use Repeatex.Helper

  match_type :monthly, ~r/month(ly)?/

  match_freq 1, ~r/monthly/
  match_freq 1, ~r/(each|every|of the).month/
  match_freq 2, ~r/bi-?month(ly)?/
  match_freq 2, ~r/(each|every).other.month/
  match_freq "digit", ~r/(?<digit>\d+).month/

  @monthly_days ~r/(?<digit>\d+)(st|nd|rd|th).?((?<day>sun|mon|tues?|wedn?e?s?|thurs?|fri|satu?r?)($|day| ))?/

  def tokenize(nil), do: nil
  def tokenize(description) do
    case %Repeat{type: type(description), days: days(description), frequency: frequency(description)} do
      %Repeat{frequency: nil} -> nil
      %Repeat{days: []} -> nil
      %Repeat{type: type} when type != :monthly -> nil
      %Repeat{days: days} when not is_list(days) -> nil
      %Repeat{days: days} = repeat ->
        if valid_days?(days), do: repeat
    end
  end

  def days(description) do
    @monthly_days |> Regex.scan(description) |> Enum.map(fn
      ([_, digit, _]) -> String.to_integer digit
      ([_, digit, _, day_desc | _]) -> {String.to_integer(digit), find_day(day_desc)}
    end) |> sort_days
  end

  defp sort_days(days) do
    Enum.sort_by days, fn
      ({num, _}) -> num
      (num) -> num
    end
  end

  defp valid_days?(days) do
    Enum.all? days, fn
      ({week, day}) -> week <= 4
      (day) -> day <= 31
    end
  end

end
