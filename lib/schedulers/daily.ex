defmodule Repeatex.Scheduler.Daily do
  alias Repeatex.Repeat

  def next_date(%Repeat{type: :daily, frequency: frequency}, {_, _, _} = date) when is_integer(frequency) do
    :edate.shift(date, frequency, :days)
  end

end
