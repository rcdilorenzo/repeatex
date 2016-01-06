defmodule Repeatex.Scheduler.Daily do
  @behaviour Repeatex.Scheduler

  def next_date(%Repeatex{type: :daily, frequency: frequency}, {_, _, _} = date) when is_integer(frequency) do
    :edate.shift(date, frequency, :days)
  end
end
