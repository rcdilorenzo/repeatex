defmodule Tokenizers.WeeklyTest do
  use Amrita.Sweet
  alias Repeatex.Tokenizer.Weekly
  alias Repeatex.Tokenizer

  test "validating days" do
    refute Weekly.valid_days?([])
    refute Weekly.valid_days?([:tuesday, :friday, "other"])
    refute Weekly.valid_days?([:monday, :monday, :saturday])
    assert Weekly.valid_days?([:monday, :wednesday, :saturday])
  end

  facts "validation" do
    it "should return nil when invalid" do
      Tokenizer.tokenize("", Weekly) |> nil
      Tokenizer.tokenize(nil, Weekly) |> nil
      Tokenizer.tokenize("every day", Weekly) |> nil
      Tokenizer.tokenize("every year", Weekly) |> nil
      Tokenizer.tokenize("3rd of every month", Weekly) |> nil
      Tokenizer.tokenize("I love weeks", Weekly) |> nil
      Tokenizer.tokenize("on the 3rd tuesday of every month", Weekly) |> nil
    end
  end

  facts "tokenize" do
    it "parses single day" do
      Tokenizer.tokenize("every other monday", Weekly)
        |> equals %Repeatex{days: [:monday], type: :weekly, frequency: 2}

      Tokenizer.tokenize("every week on thursday", Weekly)
        |> equals %Repeatex{days: [:thursday], type: :weekly, frequency: 1}

      Tokenizer.tokenize("on thursdays", Weekly)
        |> equals %Repeatex{days: [:thursday], type: :weekly, frequency: 1}

      Tokenizer.tokenize("each wed", Weekly)
        |> equals %Repeatex{days: [:wednesday], type: :weekly, frequency: 1}
    end

    it "parses sequential days" do
      Tokenizer.tokenize("mon-sat weekly", Weekly)
        |> equals %Repeatex{days: [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday], type: :weekly, frequency: 1}

      Tokenizer.tokenize("every week on mon-sat", Weekly)
        |> equals %Repeatex{days: [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday], type: :weekly, frequency: 1}

      Tokenizer.tokenize("every week on fri-sun", Weekly)
        |> equals %Repeatex{days: [:sunday, :friday, :saturday], type: :weekly, frequency: 1}

      Tokenizer.tokenize("every week on fri-mon", Weekly)
        |> equals %Repeatex{days: [:sunday, :monday, :friday, :saturday], type: :weekly, frequency: 1}

      Tokenizer.tokenize("biweekly on sat", Weekly)
        |> equals %Repeatex{days: [:saturday], type: :weekly, frequency: 2}
    end
  end

end
