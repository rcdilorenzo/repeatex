defmodule Repeatex.Scheduler.Monthly do
  @behaviour Repeatex.Scheduler
  import Repeatex.Helper

  def next_date(%Repeatex{days: days, type: :monthly, frequency: 1}, date) when is_map(days) do
    next_date(%Repeatex{days: days, type: :monthly, frequency: 0}, date)
  end

  def next_date(%Repeatex{days: days, type: :monthly, frequency: frequency}, date) when is_map(days) and is_integer(frequency) do
    dates = for shift <- 0..1, key <- Map.keys(days) do
      {year, month, _} = :edate.shift(date, frequency + shift, :month)
      day_of_month(year, month, key, days[key])
    end
      |> Enum.sort(&(:edate.is_after(&2, &1)))
      |> Enum.find(&(:edate.is_after(&1, date)))
  end

  def next_date(%Repeatex{days: days, type: :monthly, frequency: frequency}, {_, _, day} = date) when is_integer(frequency) do
    case next_number(days, day) - day do
      diff when diff < 0 ->
        :edate.shift(date, diff, :days)
          |> :edate.shift(frequency, :month)
      diff ->
        :edate.shift(date, diff, :days)
    end
  end

  def day_of_month(year, month, day_of_week, increment) do
    case index_of_day(day_of_week) - index_of_day(first_day_of_week_in_month(year, month)) do
      shift when shift < 0 ->
        {year, month, 1} |> :edate.shift(7 + shift, :days)
      shift when shift >= 0 ->
        {year, month, 1} |> :edate.shift(shift, :days)
    end |> :edate.shift(increment - 1, :week)
  end

  defp first_day_of_week_in_month(year, month) do
    {year, month, 1}
      |> :edate.day_of_week
      |> to_string
      |> String.to_existing_atom
  end
end
