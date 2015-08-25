defmodule Repeatex.Scheduler do
  alias Repeatex.Helper

  def next_allowed_day(day_of_week, allowed_days) do
    day = Helper.next_day_of_week(day_of_week)
    case Enum.member?(allowed_days, day) do
      true -> day
      false -> next_allowed_day day, allowed_days
    end
  end

end
