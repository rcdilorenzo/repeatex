defmodule Repeatex.Tokenizer.Weekly do
  alias Repeatex.Repeat
  import Repeatex.Helper

  @frequency %{
    ~r/^(sun|mon|tues?|wedn?e?s?|thurs?|fri|satu?r?)d?a?y?s?$/ => 1,
    ~r/(each|every|of the) (week|sun|mon|tues?|wedn?e?s?|thurs?|fri|satu?r?)/ => 1,
    ~r/bi-?weekly/ => 2,
    ~r/(?<digit>\d+).(week)/ => "digit"
  }

  @sequential ~r/(?<start>sun|mon|tues?|wedn?e?s?|thurs?|fri|satu?r?)d?a?y?-(?<end>sun|mon|tues?|wedn?e?s?|thurs?|fri|satu?r?)d?a?y?/

  def tokenize(nil), do: nil
  def tokenize(description) do
    case %Repeat{type: type(description), days: days(description), frequency: frequency(description)} do
      %Repeat{frequency: nil} -> nil
      %Repeat{days: []} -> nil
      %Repeat{type: type} when type != :weekly -> nil
      %Repeat{days: days} when not is_list(days) -> nil
      %Repeat{days: days} = repeat ->
        if Enum.all?(days, &(&1 in Repeat.all_days)), do: repeat
    end
  end

  defp type(description) do
    if Regex.match?(~r/(daily|week(ly)?)/, description), do: :weekly
  end

  defp frequency(description) do
    @frequency |> Enum.find_value fn
      ({regex, freq}) when is_integer(freq) ->
        if Regex.match?(regex, description), do: freq
      ({regex, key}) when is_binary(key) ->
        if Regex.match?(regex, description) do
          Regex.named_captures(regex, description)[key] |> String.to_integer
        end
    end
  end

  defp days(description) do
    cond do
      Regex.match?(~r/daily/, description) ->
        Repeatex.Repeat.all_days

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
