defmodule Schedulers.WeeklyTest do
  use ExUnit.Case
  alias Repeatex.Scheduler.Weekly

  test "schedules for every day" do
    assert Weekly.next_date(repeat([:monday, :friday], 1), {2015, 3, 16}) == {2015, 3, 20}
    assert Weekly.next_date(repeat([:monday], 1), {2015, 3, 18}) == {2015, 3, 23}

    assert Weekly.next_date(repeat([:monday], 2), {2015, 3, 18}) == {2015, 3, 30}
    assert Weekly.next_date(repeat([:monday], 3), {2015, 3, 18}) == {2015, 4, 6}

    assert Weekly.next_date(repeat([:tuesday, :saturday], 3), {2015, 3, 18}) == {2015, 3, 21}
    assert Weekly.next_date(repeat([:tuesday, :thursday, :saturday], 3), {2015, 3, 18}) == {2015, 3, 19}
  end

  test "does not use the same day when non sequential days chosen" do
    repeatex = repeat([:thursday], 1)
    assert Weekly.next_date(repeatex, {2016, 6, 16}) == {2016, 6, 23}
  end

  defp repeat(days, frequency) do
    %Repeatex{days: days, type: :weekly, frequency: frequency}
  end
end
