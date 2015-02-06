defmodule Repeatex.Tokenizer.Yearly do
  use Repeatex.Helper

  match_type :yearly, ~r/(year|annual)/

  match_freq 1, ~r/(yearly|annually)/
  match_freq 1, ~r/(each|every|of the).year/
  match_freq 2, ~r/bi-year(ly)?/
  match_freq 2, ~r/(each|every).other.year/
  match_freq "digit", ~r/(?<digit>\d+).year/

  @yearly_days ~r/(?<month>jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec)\w* (?<day>\d+)/i

  def tokenize(nil), do: nil
  def tokenize(description) do
    case %Repeat{type: type(description), days: days(description), frequency: frequency(description)} do
      %Repeat{frequency: nil} -> nil
      %Repeat{days: []} -> nil
      %Repeat{type: type} when type != :yearly -> nil
      %Repeat{days: days} when not is_list(days) -> nil
      %Repeat{days: days} = repeat ->
        if valid_days?(days), do: repeat
    end
  end

  def days(description) do
    @yearly_days |> Regex.scan(description) |> Enum.map fn
      ([_, month, day]) -> {find_month(month), String.to_integer(day)}
    end
  end

  defp valid_days?(days) do
    Enum.all? days, fn
      ({month, day}) -> valid_month?(month)
    end
  end

end
