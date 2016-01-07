defmodule Tokenizers.YearlyTest do
  use Amrita.Sweet
  alias Repeatex.Tokenizer.Yearly
  alias Repeatex.Tokenizer

  test "validating days" do
    refute Yearly.valid_days?(%{})
    refute Yearly.valid_days?(%{blah: 3})
    refute Yearly.valid_days?(%{march: 40})
    assert Yearly.valid_days?(%{january: 3})
    # TODO: validate days in month (e.g. february no more than 29)
  end

  facts "validation" do
    it "should return nil when invalid" do
      Tokenizer.tokenize("", Yearly) |> nil
      Tokenizer.tokenize(nil, Yearly) |> nil
      Tokenizer.tokenize("every day", Yearly) |> nil
      Tokenizer.tokenize("3rd of every month", Yearly) |> nil
      Tokenizer.tokenize("I love years", Yearly) |> nil
    end

    # it "only allows max days based on month"
  end

  facts "tokenize" do
    it "parses monthy/day" do
      Tokenizer.tokenize("every jan 3 annually", Yearly)
        |> equals %Repeatex{days: %{january: 3}, type: :yearly, frequency: 1}

      Tokenizer.tokenize("dec 25 every 2 years", Yearly)
        |> equals %Repeatex{days: %{december: 25}, type: :yearly, frequency: 2}
    end
  end

end
