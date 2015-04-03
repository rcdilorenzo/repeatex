defmodule Repeatex.Tokenizer.Daily do
  use Repeatex.Helper

  match_type :daily, ~r/(days?|daily)/

  match_freq 1, ~r/(^daily$)|(every|each)(\s|^)day/
  match_freq 2, ~r/every\s?other\s?day/
  match_freq "digit", ~r/(every|each).(?<digit>\d+)[\w\s]{0,3}day/

  def tokenize(nil), do: nil
  def tokenize(description) do
    case %Repeat{type: type(description), frequency: frequency(description)} do
      %Repeat{frequency: nil} -> nil
      %Repeat{type: type} when type != :daily -> nil
      repeat -> repeat
    end
  end

  def format(%Repeat{} = repeat) do
    case repeat do
      %Repeat{type: type} when type != :daily -> nil
      %Repeat{frequency: 1} -> "daily"
      %Repeat{frequency: 2} -> "every other day"
      %Repeat{frequency: num} when is_integer(num) -> "every #{num} days"
      _ -> nil
    end
  end


end
