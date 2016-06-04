defmodule Tokenizers.YearlyTest do
  use ExUnit.Case
  alias Repeatex.Tokenizer.Yearly
  alias Repeatex.Tokenizer

  test "validating days" do
    refute Yearly.valid_days?(%{})
    refute Yearly.valid_days?(%{blah: 3})
    refute Yearly.valid_days?(%{march: 40})
    assert Yearly.valid_days?(%{january: 3})
    # TODO: validate days in month (e.g. february no more than 29)
  end

  test "should return nil when invalid" do
    refute Tokenizer.tokenize("", Yearly)
    refute Tokenizer.tokenize(nil, Yearly)
    refute Tokenizer.tokenize("every day", Yearly)
    refute Tokenizer.tokenize("3rd of every month", Yearly)
    refute Tokenizer.tokenize("I love years", Yearly)
  end

  # test "only allows max days based on month"

  test "parses monthy/day" do
    assert Tokenizer.tokenize("every jan 3 annually", Yearly)
      == %Repeatex{days: %{january: 3}, type: :yearly, frequency: 1}

    assert Tokenizer.tokenize("dec 25 every 2 years", Yearly)
      == %Repeatex{days: %{december: 25}, type: :yearly, frequency: 2}
  end
end
