defmodule Formatters.DailyTest do
  use Amrita.Sweet
  alias Repeatex.Formatter.Daily

  facts "formatting" do
    it "should print description of a repeat" do
      Daily.format(%Repeatex{days: [], type: :daily, frequency: 2})
        |> equals "Every other day"

      Daily.format(%Repeatex{days: [], type: :daily, frequency: 1})
        |> equals "Daily"

      Daily.format(%Repeatex{days: [], type: :daily, frequency: 30})
        |> equals "Every 30 days"
    end
  end

end
