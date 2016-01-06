defmodule Formatters.WeeklyTest do
  use Amrita.Sweet
  alias Repeatex.Formatter.Weekly

  facts "formatting" do
    it "should print description of a repeat" do
      Weekly.format(%Repeatex{days: [:monday, :tuesday], type: :weekly, frequency: 1})
        |> equals "Every week on Mon and Tue"

      Weekly.format(%Repeatex{days: [:monday, :tuesday, :wednesday], type: :weekly, frequency: 1})
        |> equals "Every week on Mon, Tue, and Wed"

      Weekly.format(%Repeatex{days: [:monday, :tuesday, :wednesday], type: :weekly, frequency: 2})
        |> equals "Every other week on Mon, Tue, and Wed"

      Weekly.format(%Repeatex{days: [:tuesday, :wednesday], type: :weekly, frequency: 3})
        |> equals "Every 3 weeks on Tue and Wed"
    end
  end

end
