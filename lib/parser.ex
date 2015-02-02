defmodule Repeatex.Parser do
  alias Repeatex.Tokenizer, as: Tokenizer

  @all [ :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday ]

  def parse(description) do
    type = Tokenizer.type(description)
    days = case type do
      :weekly ->
        Tokenizer.days description
      :monthly ->
        Tokenizer.monthly_days description
      :yearly ->
        Tokenizer.yearly_days description
      :unknown -> []
    end
    frequency = Tokenizer.frequency(description)
    %Repeatex.Repeat{type: type, days: days, frequency: frequency}
  end


  def weekly?(description) do
    week_based = Regex.match?(~r/(daily|week(ly)?)/, description)
    if !monthly?(description) and !yearly?(description) do
      Repeatex.Tokenizer.days(description) != [] or week_based
    else
      week_based
    end
  end

  def monthly?(description) do
    ~r/month/ |> Regex.match? description
  end

  def yearly?(description) do
    ~r/(year|annual)/ |> Regex.match? description
  end

end
