defmodule Repeatex.Parser do

  @all [ :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday ]


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
