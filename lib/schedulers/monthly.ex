defmodule Repeatex.Scheduler.Monthly do
  @behaviour Repeatex.Scheduler
  import Repeatex.Helper

  def next_date(%Repeatex{days: [{_, _} | _] = days, type: :monthly, frequency: frequency}, date) when is_integer(frequency) do
    date_in_month = {year, month, _} = case frequency do
      1 -> date
      _ -> :edate.shift(date, frequency, :month)
    end
    {next_year, next_month, _} = :edate.shift(date_in_month, 1, :month)

    Stream.map(days, fn (_) -> {year, month} end)
      |> Stream.concat(Stream.map(days, fn (_) -> {next_year, next_month} end))
      |> Stream.zip(days ++ days)
      |> Stream.map(&day_of_month/1)
      |> Enum.sort(fn (next_date1, next_date2) ->
        :edate.is_after(next_date2, next_date1)
      end)
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

  def day_of_month({{year, month}, {increment, day_of_week}}) do
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
