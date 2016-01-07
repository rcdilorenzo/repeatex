defmodule Formatters.MonthlyTest do
  use Amrita.Sweet
  alias Repeatex.Formatter.Monthly

  facts "formatting" do
    it "should print description of a repeat" do
      Monthly.format(%Repeatex{days: [1, 2], type: :monthly, frequency: 1})
        |> equals "1st and 2nd every month"

      Monthly.format(%Repeatex{days: [21, 23, 24], type: :monthly, frequency: 2})
        |> equals "21st, 23rd, and 24th every other month"

      Monthly.format(%Repeatex{days: %{tuesday: 3, monday: 2}, type: :monthly, frequency: 4})
        |> equals "2nd Mon and 3rd Tue every 4 months"

      Monthly.format(%Repeatex{days: %{tuesday: 3}, type: :monthly, frequency: 4})
        |> equals "3rd Tue every 4 months"
    end
  end

end
