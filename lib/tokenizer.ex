defmodule Repeatex.Tokenizer do
  import Repeatex.Parser

  @days %{
    sunday: ~r/sun(day)?/,
    monday: ~r/mon(day)?/,
    tuesday: ~r/tues?(day)?/,
    wednesday: ~r/wedn?e?s?(day)?/,
    thursday: ~r/thurs?(day)?/,
    friday: ~r/fri(day)?/,
    saturday: ~r/satu?r?(day)?/,
  }
  @frequency %{
    ~r/(each|every|of the) (week|month|year)/ => 1,
    ~r/(daily|annually)/ => 1,
    ~r/(each|every)? ?other (week|month|year)/ => 2,
    ~r/bi-(week|month|year)/ => 2,
    ~r/(?<digit>\d+).(week|month|year)/ => "digit"
  }
  @sequential ~r/(?<start>sun|mon|tues?|wedn?e?s?|thurs?|fri|satu?r?)d?a?y?-(?<end>sun|mon|tues?|wedn?e?s?|thurs?|fri|satu?r?)d?a?y?/

  def type(description) do
    cond do
      weekly?(description)  -> :weekly
      monthly?(description) -> :monthly
      yearly?(description)  -> :yearly
      true -> :unknown
    end
  end

  def frequency(description) do
    @frequency |> Enum.find_value fn
      ({regex, freq}) when is_integer(freq) ->
        if Regex.match?(regex, description), do: freq
      ({regex, key}) when is_binary(key) ->
        if Regex.match?(regex, description) do
          Regex.named_captures(regex, description)[key] |> String.to_integer
        end
    end
  end

  def days(description) do
    if sequential_days?(description) do
      %{"start" => first, "end" => second} = Regex.named_captures(@sequential, description)
      Repeatex.Helper.seq_days(find_day(first), find_day(second))
    else
      @days |> Enum.filter_map fn ({_, regex}) ->
        Regex.match? regex, description
      end, (fn ({atom, _}) -> atom end)
    end
  end

  def sequential_days?(description) do
    Regex.match? @sequential, description
  end

  defp find_day(day_description) do
    @days |> Enum.find_value fn ({atom, regex}) ->
      if Regex.match?(regex, day_description), do: atom
    end
  end

end
