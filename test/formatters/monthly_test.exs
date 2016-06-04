defmodule Formatters.MonthlyTest do
  use ExUnit.Case
  alias Repeatex.Formatter.Monthly

  test "should print description of a repeat" do
    assert Monthly.format(%Repeatex{days: [1, 2], type: :monthly, frequency: 1})
      == "1st and 2nd every month"

    assert Monthly.format(%Repeatex{days: [21, 23, 24], type: :monthly, frequency: 2})
      == "21st, 23rd, and 24th every other month"

    assert Monthly.format(%Repeatex{days: %{tuesday: 3, monday: 2}, type: :monthly, frequency: 4})
      == "2nd Mon and 3rd Tue every 4 months"

    assert Monthly.format(%Repeatex{days: %{tuesday: 3}, type: :monthly, frequency: 4})
      == "3rd Tue every 4 months"
  end
end
