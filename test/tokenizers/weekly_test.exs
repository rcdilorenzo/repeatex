defmodule Tokenizers.WeeklyTest do
  use Amrita.Sweet
  alias Repeatex.Tokenizer.Weekly
  alias Repeatex.Repeat

  facts "validation" do
    it "should return nil when invalid" do
      Weekly.tokenize("") |> nil
      Weekly.tokenize(nil) |> nil
      Weekly.tokenize("every day") |> nil
      Weekly.tokenize("every year") |> nil
      Weekly.tokenize("3rd of every month") |> nil
      Weekly.tokenize("I love weeks") |> nil
      Weekly.tokenize("on the 3rd tuesday of every month") |> nil
    end
  end

  facts "tokenize" do
    it "parses single day" do
      Weekly.tokenize("every week on thursday")
        |> equals %Repeat{days: [:thursday], type: :weekly, frequency: 1}

      Weekly.tokenize("each wed")
        |> equals %Repeat{days: [:wednesday], type: :weekly, frequency: 1}
    end

    it "parses sequential days" do
      Weekly.tokenize("every week on mon-sat")
        |> equals %Repeat{days: [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday], type: :weekly, frequency: 1}

      Weekly.tokenize("every week on fri-sun")
        |> equals %Repeat{days: [:sunday, :friday, :saturday], type: :weekly, frequency: 1}

      Weekly.tokenize("every week on fri-mon")
        |> equals %Repeat{days: [:sunday, :monday, :friday, :saturday], type: :weekly, frequency: 1}

      Weekly.tokenize("biweekly on sat")
        |> equals %Repeat{days: [:saturday], type: :weekly, frequency: 2}
    end
  end

end
