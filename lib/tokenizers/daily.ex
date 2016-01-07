defmodule Repeatex.Tokenizer.Daily do
  @behaviour Repeatex.Tokenizer
  use Repeatex.Helper

  match_type :daily, ~r/(days?|daily)/

  match_freq 1, ~r/(^daily$)|(every|each)(\s|^)day/
  match_freq 2, ~r/every\s?other\s?day/
  match_freq "digit", ~r/(every|each).(?<digit>\d+)[\w\s]{0,3}day/

  def days(_), do: []
  def valid_days?([]), do: true
  def valid_days?(_), do: false

end
