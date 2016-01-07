defmodule Tokenizers.DailyTest do
  use Amrita.Sweet
  alias Repeatex.Tokenizer.Daily
  alias Repeatex.Tokenizer

  test "validating days" do
    refute Daily.valid_days?(%{})
    refute Daily.valid_days?([1, 2])
    assert Daily.valid_days?([])
  end

  facts "validation" do
    it "should return nil when invalid" do
      Tokenizer.tokenize("", Daily) |> nil
      Tokenizer.tokenize(nil, Daily) |> nil
      Tokenizer.tokenize("mon-sat every week", Daily) |> nil
      Tokenizer.tokenize("every year", Daily) |> nil
      Tokenizer.tokenize("3rd of every month", Daily) |> nil
      Tokenizer.tokenize("every other monday", Daily) |> nil
      Tokenizer.tokenize("I love days", Daily) |> nil
    end
  end

  facts "tokenize" do
    it "parses day expression" do
      Tokenizer.tokenize("every other day", Daily)
        |> equals %Repeatex{days: [], type: :daily, frequency: 2}

      Tokenizer.tokenize("every day", Daily)
        |> equals %Repeatex{days: [], type: :daily, frequency: 1}

      Tokenizer.tokenize("daily", Daily)
        |> equals Tokenizer.tokenize("every day", Daily)
    end

    it "parses number" do
      Tokenizer.tokenize("every 5 days", Daily)
        |> equals %Repeatex{days: [], type: :daily, frequency: 5}

      Tokenizer.tokenize("every 23rd day", Daily)
        |> equals %Repeatex{days: [], type: :daily, frequency: 23}

    end
  end

end
