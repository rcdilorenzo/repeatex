defmodule Formatters.DailyTest do
  use Amrita.Sweet
  alias Repeatex.Formatter.Daily
  alias Repeatex.Repeat

  facts "formatting" do
    it "should print description of a repeat" do
      Daily.format(%Repeat{days: [], type: :daily, frequency: 2})
        |> equals "every other day"

      Daily.format(%Repeat{days: [], type: :daily, frequency: 1})
        |> equals "daily"

      Daily.format(%Repeat{days: [], type: :daily, frequency: 30})
        |> equals "every 30 days"
    end
  end

end
