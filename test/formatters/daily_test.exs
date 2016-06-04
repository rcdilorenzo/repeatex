defmodule Formatters.DailyTest do
  use ExUnit.Case
  alias Repeatex.Formatter.Daily

  test "should print description of a repeat" do
    assert Daily.format(%Repeatex{days: [], type: :daily, frequency: 2})
      == "Every other day"

    assert Daily.format(%Repeatex{days: [], type: :daily, frequency: 1})
      == "Daily"

    assert Daily.format(%Repeatex{days: [], type: :daily, frequency: 30})
      == "Every 30 days"
  end
end
