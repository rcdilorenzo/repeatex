defmodule Repeatex.Scheduler do

  def increment_date({_, _, _} = date) do
    :edate.shift(date, 1, :day)
  end
end
