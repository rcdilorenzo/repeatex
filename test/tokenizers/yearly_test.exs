defmodule Tokenizers.YearlyTest do
  use Amrita.Sweet
  alias Repeatex.Tokenizer.Yearly
  alias Repeatex.Repeat

  facts "validation" do
    it "should return nil when invalid" do
      Yearly.tokenize("") |> nil
      Yearly.tokenize(nil) |> nil
      Yearly.tokenize("every day") |> nil
      Yearly.tokenize("3rd of every month") |> nil
      Yearly.tokenize("I love years") |> nil
    end

    it "only allows max days based on month"
  end

  facts "tokenize" do
    it "parses monthy/day" do
      Yearly.tokenize("every jan 3 annually")
        |> equals %Repeat{days: [january: 3], type: :yearly, frequency: 1}

      Yearly.tokenize("dec 25 every 2 years")
        |> equals %Repeat{days: [december: 25], type: :yearly, frequency: 2}
    end
  end

end
