defmodule SchedulerTest do
  use Amrita.Sweet
  import Repeatex.Scheduler

  it "determines next day of week" do
    next_allowed_day(:monday, [:tuesday, :saturday]) |> equals :tuesday
  end
end
