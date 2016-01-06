defmodule Repeatex.Tokenizer.Weekly do
  @behaviour Repeatex.Tokenizer
  use Repeatex.Helper

  match_type :weekly, ~r/(each|every|bi-?|other|on|^)\s?(week|(sun|mon|tues?|wedn?e?s?|thurs?|fri|satu?r?)($|day| |-))/

  match_freq 1, ~r/^(sun|mon|tues?|wedn?e?s?|thurs?|fri|satu?r?)d?a?y?s?$/
  match_freq 1, ~r/(each|every|of the) (week|sun|mon|tues?|wedn?e?s?|thurs?|fri|satu?r?)/
  match_freq 2, ~r/(each|every|of the) other (week|sun|mon|tues?|wedn?e?s?|thurs?|fri|satu?r?)/
  match_freq "digit", ~r/(?<digit>\d+).(week)/
  match_freq 1, ~r/(^|\s)(on|weekly)/
  match_freq 2, ~r/bi-?weekly/

  @sequential ~r/(?<start>sun|mon|tues?|wedn?e?s?|thurs?|fri|satu?r?)d?a?y?-(?<end>sun|mon|tues?|wedn?e?s?|thurs?|fri|satu?r?)d?a?y?/

  def tokenize(nil), do: nil
  def tokenize(description) do
    case %Repeatex{type: type(description), days: days(description), frequency: frequency(description)} do
      %Repeatex{frequency: nil} -> nil
      %Repeatex{days: []} -> nil
      %Repeatex{type: type} when type != :weekly -> nil
      %Repeatex{days: days} when not is_list(days) -> nil
      %Repeatex{days: days} = repeat ->
        if Enum.all?(days, &(&1 in all_days)), do: repeat
    end
  end

  defp days(description) do
    cond do
      Regex.match?(~r/daily/, description) -> all_days
      sequential_days?(description) ->
        %{"start" => first, "end" => second} = Regex.named_captures(@sequential, description)
        seq_days(find_day(first), find_day(second))
      true -> find_days(description)
    end
  end

  defp sequential_days?(description) do
    Regex.match? @sequential, description
  end
end
