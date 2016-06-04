defmodule Formatters.YearlyTest do
  use ExUnit.Case
  alias Repeatex.Formatter.Yearly

  test "should print description of a repeat" do
    assert Yearly.format(%Repeatex{days: %{january: 3}, type: :yearly, frequency: 1})
      == "Jan 3rd every year"

    assert Yearly.format(%Repeatex{days: %{january: 3, april: 1}, type: :yearly, frequency: 2})
      == "Jan 3rd and Apr 1st every other year"
  end
end
