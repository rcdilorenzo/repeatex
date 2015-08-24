defmodule SchedulerTest do
  use Amrita.Sweet
  import Repeatex.Scheduler

  it "bumps the date" do
    assert increment_date({2015, 3, 15}) == {2015, 3, 16}
    assert increment_date({2015, 12, 31}) == {2016, 1, 1}
  end
end
