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
      %Repeatex{type: :monthly, days: %{friday: 3}, frequency: 1},
      {2016, 1, 10}
    ) == {2016, 1, 15}
  end

  test "returning description of repeatex using default modules" do
    assert Repeatex.description(
      %Repeatex{type: :weekly, days: [:monday], frequency: 2}
    ) == "Every other week on Mon"
  end

  test "parsing from json with daily repeat" do
    assert Repeatex.parse_json(%{
      "type" => "weekly",
      "days" => ["monday"],
      "frequency" => 2
    }) == %Repeatex{type: :weekly, days: [:monday], frequency: 2}

    assert Repeatex.parse_json(%{
      "type" => "daily",
      "days" => [1],
      "frequency" => 1
    }) == nil
  end

end
