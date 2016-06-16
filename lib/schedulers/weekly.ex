defmodule Repeatex.Scheduler.Weekly do
  @behaviour Repeatex.Scheduler
  import Repeatex.Helper

  def next_date(%Repeatex{days: days, type: :weekly, frequency: frequency}, {_, _, _} = date) when is_integer(frequency) do
    current_day = :edate.day_of_week(date) |> to_string |> String.to_existing_atom
    next_day = next_allowed_day(current_day, days)

    case index_of_day(next_day) - index_of_day(current_day) do
      diff when diff < 0 ->
        :edate.shift(date, diff, :days)
          |> :edate.shift(frequency, :week)
      0 ->
        :edate.shift(date, frequency, :week)
      diff ->
        :edate.shift(date, diff, :days)
    end
  end

end
