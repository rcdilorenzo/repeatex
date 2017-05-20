defmodule Repeatex.Tokenizer.Weekly do
  @behaviour Repeatex.Tokenizer
  use Repeatex.Helper

  @implicit_week ~r/(each|every|of the|on)\s?(\d+\w*|\w+)?\s?(sun|mon|tues?|wedn?e?s?|thurs?|fri|satu?r?)/i

  match_freq "digit", ~r/(?<digit>\d+)(st|nd|rd|th|\s).?(weeks?|sun|mon|tues?|wedn?e?s?|thurs?|fri|satu?r?)/i
  match_freq 1, ~r/^(sun|mon|tues?|wedn?e?s?|thurs?|fri|satu?r?)d?a?y?s?$/i
  match_freq 1, ~r/(each|every|of the) (week|sun|mon|tues?|wedn?e?s?|thurs?|fri|satu?r?)/i
  match_freq 2, ~r/(each|every|of the) other (week|sun|mon|tues?|wedn?e?s?|thurs?|fri|satu?r?)/i
  match_freq 2, ~r/bi-?weekly/i
  match_freq 1, ~r/(^|\s)(on|weekly)/i

  @sequential ~r/(?<start>sun|mon|tues?|wedn?e?s?|thurs?|fri|satu?r?)d?a?y?-(?<end>sun|mon|tues?|wedn?e?s?|thurs?|fri|satu?r?)d?a?y?/i

  def type, do: :weekly

  def type(description) do
    if (Regex.match?(@implicit_week, description)
    or Regex.match?(~r/(^|\s)week(s|ly)?(\s|$)/i, description)) and
    not Regex.match?(~r/(^|\s)month(s|ly)?(\s|$)/i, description) and
    not Regex.match?(~r/(^|\s)days?(\s|$)/i, description), do: :weekly
  end

  def valid_days?([]), do: false
  def valid_days?(days) when is_list(days) do
    Enum.uniq(days) == days and Enum.all?(days, &(&1 in all_days))
  end
  def valid_days?(_), do: false

  def days(description) do
    days = cond do
      Regex.match?(~r/daily/i, description) -> all_days
      sequential_days?(description) ->
        %{"start" => first, "end" => second} = Regex.named_captures(@sequential, description)
        seq_days(find_day(first), find_day(second))
      true -> find_days(description)
    end
    if valid_days?(days), do: days
  end

  defp sequential_days?(description) do
    Regex.match? @sequential, description
  end
end
