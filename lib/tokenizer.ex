defmodule Repeatex.Tokenizer do

  @days %{
    sunday: ~r/sun(day)?/,
    monday: ~r/mon(day)?/,
    tuesday: ~r/tues?(day)?/,
    wednesday: ~r/wedn?e?s?(day)?/,
    thursday: ~r/thurs?(day)?/,
    friday: ~r/fri(day)?/,
    saturday: ~r/satu?r?(day)?/,
  }
  @sequential ~r/(?<start>sun|mon|tues?|wedn?e?s?|thurs?|fri|satu?r?)d?a?y?-(?<end>sun|mon|tues?|wedn?e?s?|thurs?|fri|satu?r?)d?a?y?/


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
