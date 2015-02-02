defmodule Tokenizers.DailyTest do
  use Amrita.Sweet
  alias Repeatex.Tokenizer.Daily
  alias Repeatex.Repeat

  facts "validation" do
    it "should return nil when invalid" do
      Daily.tokenize("") |> nil
      Daily.tokenize(nil) |> nil
      Daily.tokenize("mon-sat every week") |> nil
      Daily.tokenize("every year") |> nil
      Daily.tokenize("3rd of every month") |> nil
      Daily.tokenize("I love days") |> nil
    end
  end

  facts "tokenize" do
    it "parses day expression" do
      Daily.tokenize("every other day")
        |> equals %Repeat{days: [], type: :daily, frequency: 2}

      Daily.tokenize("every day")
        |> equals %Repeat{days: [], type: :daily, frequency: 1}

      Daily.tokenize("daily")
        |> equals Daily.tokenize("every day")
    end

    it "parses number" do
      Daily.tokenize("every 5 days")
        |> equals %Repeat{days: [], type: :daily, frequency: 5}

      Daily.tokenize("every 23rd day")
        |> equals %Repeat{days: [], type: :daily, frequency: 23}

    end
  end

end
