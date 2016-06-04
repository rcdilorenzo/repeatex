defmodule Formatters.WeeklyTest do
  use ExUnit.Case
  alias Repeatex.Formatter.Weekly

  test "should print description of a repeat" do
    assert Weekly.format(%Repeatex{days: [:monday, :tuesday], type: :weekly, frequency: 1})
      == "Every week on Mon and Tue"

    assert Weekly.format(%Repeatex{days: [:monday, :tuesday, :wednesday], type: :weekly, frequency: 1})
      == "Every week on Mon, Tue, and Wed"

    assert Weekly.format(%Repeatex{days: [:monday, :tuesday, :wednesday], type: :weekly, frequency: 2})
      == "Every other week on Mon, Tue, and Wed"

    assert Weekly.format(%Repeatex{days: [:tuesday, :wednesday], type: :weekly, frequency: 3})
      == "Every 3 weeks on Tue and Wed"
  end
end
