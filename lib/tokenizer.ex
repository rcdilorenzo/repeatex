defmodule Repeatex.Tokenizer do
  import Repeatex.Parser
  import Repeatex.Helper

  @months %{
    january:   ~r/jan(uary)?/i,
    february:  ~r/feb(ruary)?/i,
    march:     ~r/mar(ch)?/i,
    april:     ~r/apr(il)?/i,
    may:       ~r/may/i,
    june:      ~r/june?/i,
    july:      ~r/july?/i,
    august:    ~r/aug(ust)?/i,
    september: ~r/sep(tember)?/i,
    october:   ~r/oct(uary)?/i,
    november:  ~r/nov(ember)?/i,
    december:  ~r/dec(ember)?/i,
  }
  @frequency %{
    ~r/(each|every|of the) (week|month|year|sun|mon|tues?|wedn?e?s?|thurs?|fri|satu?r?)/ => 1,
    ~r/(each|every)? ?other (week|month|year|sun|mon|tues?|wedn?e?s?|thurs?|fri|satu?r?)/ => 2,
    ~r/bi-(week|month|year)/ => 2,
    ~r/(daily|annually|weekly)/ => 1,
    ~r/(?<digit>\d+).(week|month|year)/ => "digit"
  }
  @monthly_days ~r/(?<digit>\d+)(st|nd|rd|th).?(?<day>sun|mon|tues?|wedn?e?s?|thurs?|fri|satu?r?)?/
  @yearly_days ~r/(?<month>jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec)\w* (?<day>\d+)/i

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

  def monthly_days(description) do
    @monthly_days |> Regex.scan(description) |> Enum.map fn
      ([_, digit, _]) -> String.to_integer digit
      ([_, digit, _, day_desc]) -> {String.to_integer(digit), find_day(day_desc)}
    end
  end

  def yearly_days(description) do
    @yearly_days |> Regex.scan(description) |> Enum.map fn
      ([_, month, day]) -> {find_month(month), String.to_integer(day)}
    end
  end

  defp find_month(month_description) do
    @months |> Enum.find_value fn ({atom, regex}) ->
      if Regex.match?(regex, month_description), do: atom
    end
  end

end
