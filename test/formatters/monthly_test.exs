defmodule Formatters.MonthlyTest do
  use Amrita.Sweet
  alias Repeatex.Formatter.Monthly
  alias Repeatex.Repeat

  facts "formatting" do
    it "should print description of a repeat" do
      Monthly.format(%Repeat{days: [1, 2], type: :monthly, frequency: 1})
        |> equals "1st and 2nd every month"

      Monthly.format(%Repeat{days: [21, 23, 24], type: :monthly, frequency: 2})
        |> equals "21st, 23rd, and 24th every other month"

      Monthly.format(%Repeat{days: [{3, :tuesday}, {2, :monday}], type: :monthly, frequency: 4})
        |> equals "3rd Tue and 2nd Mon every 4 months"
    end
  end

end
