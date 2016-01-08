defmodule Repeatex.Tokenizer.Daily do
  @behaviour Repeatex.Tokenizer
  use Repeatex.Helper

  match_type :daily, ~r/(days?|daily)/i

  match_freq 1, ~r/(^daily$)|(every|each)(\s|^)day/i
  match_freq 2, ~r/every\s?other\s?day/i
  match_freq "digit", ~r/(every|each).(?<digit>\d+)[\w\s]{0,3}day/i

  def days(_), do: []
  def valid_days?([]), do: true
  def valid_days?(_), do: false

end
