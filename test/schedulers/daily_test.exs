defmodule Schedulers.DailyTest do
  use ExUnit.Case
  alias Repeatex.Scheduler.Daily

  test "schedules for every day" do
    assert Daily.next_date(%Repeatex{type: :daily, frequency: 1}, {2015, 3, 15})
      == {2015, 3, 16}

    assert Daily.next_date(%Repeatex{type: :daily, frequency: 2}, {2015, 3, 30})
      == {2015, 4, 1}
  end
end
