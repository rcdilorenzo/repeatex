defmodule Schedulers.DailyTest do
  use Amrita.Sweet
  alias Repeatex.Scheduler.Daily
  alias Repeatex.Repeat

  it "schedules for every day" do
    Daily.next_date(%Repeat{type: :daily, frequency: 1}, {2015, 3, 15})
      |> equals {2015, 3, 16}

    Daily.next_date(%Repeat{type: :daily, frequency: 2}, {2015, 3, 30})
      |> equals {2015, 4, 1}
  end

end
