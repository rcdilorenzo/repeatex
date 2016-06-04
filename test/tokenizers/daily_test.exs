defmodule Tokenizers.DailyTest do
  use ExUnit.Case
  alias Repeatex.Tokenizer.Daily
  alias Repeatex.Tokenizer

  test "validating days" do
    refute Daily.valid_days?(%{})
    refute Daily.valid_days?([1, 2])
    assert Daily.valid_days?([])
  end

  test "should return nil when invalid" do
    refute Tokenizer.tokenize("", Daily)
    refute Tokenizer.tokenize(nil, Daily)
    refute Tokenizer.tokenize("mon-sat every week", Daily)
    refute Tokenizer.tokenize("every year", Daily)
    refute Tokenizer.tokenize("3rd of every month", Daily)
    refute Tokenizer.tokenize("every other monday", Daily)
    refute Tokenizer.tokenize("I love days", Daily)
  end

  test "parses day expression" do
    assert Tokenizer.tokenize("every other day", Daily)
      == %Repeatex{days: [], type: :daily, frequency: 2}

    assert Tokenizer.tokenize("every day", Daily)
      == %Repeatex{days: [], type: :daily, frequency: 1}

    assert Tokenizer.tokenize("daily", Daily)
      == Tokenizer.tokenize("every day", Daily)
  end

  test "parses number" do
    assert Tokenizer.tokenize("every 5 days", Daily)
      == %Repeatex{days: [], type: :daily, frequency: 5}

    assert Tokenizer.tokenize("every 23rd day", Daily)
      == %Repeatex{days: [], type: :daily, frequency: 23}

  end
end
