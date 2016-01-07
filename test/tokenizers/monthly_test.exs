defmodule Tokenizers.MonthlyTest do
  use Amrita.Sweet
  alias Repeatex.Tokenizer.Monthly
  alias Repeatex.Tokenizer

  test "validating days" do
    refute Monthly.valid_days?([])
    refute Monthly.valid_days?(%{})
    refute Monthly.valid_days?([1, 2, :other])
    refute Monthly.valid_days?([-1, 10, 15])
    refute Monthly.valid_days?([32, 43])
    assert Monthly.valid_days?(%{monday: 3, tuesday: 1})
    assert Monthly.valid_days?([1, 5, 6])
  end

  facts "validation" do
    it "should return nil when invalid" do
      Tokenizer.tokenize("", Monthly) |> nil
      Tokenizer.tokenize(nil, Monthly) |> nil
      Tokenizer.tokenize("every day", Monthly) |> nil
      Tokenizer.tokenize("every year", Monthly) |> nil
      Tokenizer.tokenize("mon-sat every week", Monthly) |> nil
      Tokenizer.tokenize("I love months", Monthly) |> nil
    end

    it "considers out-of-range as invalid" do
      Tokenizer.tokenize("every month on the 32nd", Monthly) |> nil
      Tokenizer.tokenize("5th tuesday of every month", Monthly) |> nil
    end
  end

  facts "tokenize" do

    it "parses day numbers" do
      Tokenizer.tokenize("every month on the 1st and 3rd", Monthly)
        |> equals %Repeatex{days: [1, 3], type: :monthly, frequency: 1}

      Tokenizer.tokenize("on the 3rd tuesday of every month", Monthly)
        |> equals %Repeatex{days: %{tuesday: 3}, type: :monthly, frequency: 1}
    end

    it "gets correct day order" do
      Tokenizer.tokenize("every month on the 9th and 1st", Monthly)
        |> equals %Repeatex{days: [1, 9], type: :monthly, frequency: 1}

      Tokenizer.tokenize("every month on 3rd tuesday and 2nd thursday", Monthly)
        |> equals %Repeatex{days: %{thursday: 2, tuesday: 3}, type: :monthly, frequency: 1}
    end

    it "get frequency properly with words" do
      Tokenizer.tokenize("bi-monthly on the 9th and 1st", Monthly)
        |> equals %Repeatex{days: [1, 9], type: :monthly, frequency: 2}

      Tokenizer.tokenize("every 3rd tues of every other month", Monthly)
        |> equals %Repeatex{days: %{tuesday: 3}, type: :monthly, frequency: 2}
    end

    it "does not allow mixing relative days and absolute numbers" do
      Tokenizer.tokenize("on the 3rd tuesday and 2nd of every month", Monthly)
        |> equals %Repeatex{days: %{tuesday: 3}, type: :monthly, frequency: 1}

      Tokenizer.tokenize("on the 2nd and 3rd tuesday of every month", Monthly)
        |> equals %Repeatex{days: [2], type: :monthly, frequency: 1}
      # TODO: allow specifying multiple weeks per day
    end
  end

end
