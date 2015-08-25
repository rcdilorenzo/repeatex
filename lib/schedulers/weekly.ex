defmodule Repeatex.Scheduler.Weekly do
  alias Repeatex.Repeat
  alias Repeatex.Scheduler
  import Repeatex.Helper

  def next_date(%Repeat{days: days, type: :weekly, frequency: frequency}, {_, _, _} = date) when is_integer(frequency) do
    current_day = :edate.day_of_week(date) |> to_string |> String.to_existing_atom
    next_day = Scheduler.next_allowed_day(current_day, days)

    case index_of_day(next_day) - index_of_day(current_day) do
      diff when diff < 0 ->
        :edate.shift(date, diff, :days)
          |> :edate.shift(frequency, :week)
      diff ->
        :edate.shift(date, diff, :days)
    end
  end

end
