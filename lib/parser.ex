defmodule Repeatex.Parser do

  @all [ :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday ]


  def weekly?(description) do
    !monthly?(description) and !yearly?(description)
  end

  def monthly?(description) do
    ~r/month/ |> Regex.match? description
  end

  def yearly?(description) do
    ~r/(year|annual)/ |> Regex.match? description
  end

end
