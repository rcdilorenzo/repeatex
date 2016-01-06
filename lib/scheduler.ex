defmodule Repeatex.Scheduler do
  @type year  :: non_neg_integer
  @type month :: 1..12
  @type day   :: 1..31
  @type date :: {year, month, day}

  @callback next_date(Repeatex.t, date) :: date | nil

  import Repeatex.Helper, only: [convert_and_concat: 2]

  def next(repeatex = %Repeatex{type: type}, date = {_, _, _}) do
    case convert_and_concat(__MODULE__, type) do
      nil -> IO.puts "No module found with this type"; nil
      module -> module.next_date(repeatex, date)
    end
  end
end
