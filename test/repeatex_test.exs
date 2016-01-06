defmodule RepeatexTest do
  use ExUnit.Case

  test "parsing using default modules" do
    assert Repeatex.parse("every day")
      == %Repeatex{days: [], type: :daily, frequency: 1}

    assert Repeatex.parse("mon-wed every week")
      == %Repeatex{days: [:monday, :tuesday, :wednesday], type: :weekly, frequency: 1}
  end

  test "finding next date using default modules" do
    assert Repeatex.next_date(
      %Repeatex{type: :monthly, days: [{3, :friday}], frequency: 1},
      {2016, 1, 10}
    ) == {2016, 1, 15}
  end

  test "returning description of repeatex using default modules" do
    assert Repeatex.description(
      %Repeatex{type: :weekly, days: [:monday], frequency: 2}
    ) == "Every other week on Mon"
  end

end
