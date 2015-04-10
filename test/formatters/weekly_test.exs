defmodule Formatters.WeeklyTest do
  use Amrita.Sweet
  alias Repeatex.Formatter.Weekly
  alias Repeatex.Repeat

  facts "formatting" do
    it "should print description of a repeat" do
      Weekly.format(%Repeat{days: [:monday, :tuesday], type: :weekly, frequency: 1})
        |> equals "Monday and Tuesday every week"

      Weekly.format(%Repeat{days: [:monday, :tuesday, :wednesday], type: :weekly, frequency: 1})
        |> equals "Monday, Tuesday, and Wednesday every week"

      Weekly.format(%Repeat{days: [:monday, :tuesday, :wednesday], type: :weekly, frequency: 2})
        |> equals "Monday, Tuesday, and Wednesday every other week"

      Weekly.format(%Repeat{days: [:tuesday, :wednesday], type: :weekly, frequency: 3})
        |> equals "Tuesday and Wednesday every 3 weeks"
    end
  end

end
