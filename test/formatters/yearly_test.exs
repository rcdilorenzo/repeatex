defmodule Formatters.YearlyTest do
  use Amrita.Sweet
  alias Repeatex.Formatter.Yearly
  alias Repeatex.Repeat

  facts "formatting" do
    it "should print description of a repeat" do
      Yearly.format(%Repeat{days: [january: 3], type: :yearly, frequency: 1})
        |> equals "Jan 3rd every year"

      Yearly.format(%Repeat{days: [january: 3, april: 1], type: :yearly, frequency: 2})
        |> equals "Jan 3rd and Apr 1st every other year"
    end
  end

end
