defmodule Tokenizers.MonthlyTest do
  use Amrita.Sweet
  alias Repeatex.Tokenizer.Monthly
  alias Repeatex.Repeat

  facts "validation" do
    it "should return nil when invalid" do
      Monthly.tokenize("") |> nil
      Monthly.tokenize(nil) |> nil
      Monthly.tokenize("every day") |> nil
      Monthly.tokenize("every year") |> nil
      Monthly.tokenize("mon-sat every week") |> nil
      Monthly.tokenize("I love months") |> nil
    end

    it "considers out-of-range as invalid" do
      Monthly.tokenize("every month on the 32nd") |> nil
      Monthly.tokenize("5th tuesday of every month") |> nil
    end
  end

  facts "tokenize" do

    it "parses day numbers" do
      Monthly.tokenize("every month on the 1st and 3rd")
        |> equals %Repeat{days: [1, 3], type: :monthly, frequency: 1}

      Monthly.tokenize("on the 3rd tuesday of every month")
        |> equals %Repeat{days: [{3, :tuesday}], type: :monthly, frequency: 1}
    end

    it "gets correct day order" do
      Monthly.tokenize("every month on the 9th and 1st")
        |> equals %Repeat{days: [1, 9], type: :monthly, frequency: 1}

      Monthly.tokenize("every month on 3rd tuesday and 2nd thursday")
        |> equals %Repeat{days: [{2, :thursday}, {3, :tuesday}], type: :monthly, frequency: 1}
    end

    it "get frequency properly with words" do
      Monthly.tokenize("bi-monthly on the 9th and 1st")
        |> equals %Repeat{days: [1, 9], type: :monthly, frequency: 2}

      Monthly.tokenize("every 3rd tues of every other month")
        |> equals %Repeat{days: [{3, :tuesday}], type: :monthly, frequency: 2}
    end
  end

end
