defmodule Tokenizers.MonthlyTest do
  use ExUnit.Case
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

  test "should return nil when invalid" do
    refute Tokenizer.tokenize("", Monthly)
    refute Tokenizer.tokenize(nil, Monthly)
    refute Tokenizer.tokenize("every day", Monthly)
    refute Tokenizer.tokenize("every year", Monthly)
    refute Tokenizer.tokenize("mon-sat every week", Monthly)
    refute Tokenizer.tokenize("I love months", Monthly)
  end

  test "considers out-of-range as invalid" do
    refute Tokenizer.tokenize("every month on the 32nd", Monthly)
    refute Tokenizer.tokenize("5th tuesday of every month", Monthly)
  end

  test "parses day numbers" do
    assert Tokenizer.tokenize("every month on the 1st and 3rd", Monthly)
      == %Repeatex{days: [1, 3], type: :monthly, frequency: 1}

    assert Tokenizer.tokenize("on the 3rd tuesday of every month", Monthly)
      == %Repeatex{days: %{tuesday: 3}, type: :monthly, frequency: 1}
  end

  test "gets correct day order" do
    assert Tokenizer.tokenize("every month on the 9th and 1st", Monthly)
      == %Repeatex{days: [1, 9], type: :monthly, frequency: 1}

    assert Tokenizer.tokenize("every month on 3rd tuesday and 2nd thursday", Monthly)
      == %Repeatex{days: %{thursday: 2, tuesday: 3}, type: :monthly, frequency: 1}
  end

  test "get frequency properly with words" do
    assert Tokenizer.tokenize("bi-monthly on the 9th and 1st", Monthly)
      == %Repeatex{days: [1, 9], type: :monthly, frequency: 2}

    assert Tokenizer.tokenize("every 3rd tues of every other month", Monthly)
      == %Repeatex{days: %{tuesday: 3}, type: :monthly, frequency: 2}
  end

  test "does not allow mixing relative days and absolute numbers" do
    assert Tokenizer.tokenize("on the 3rd tuesday and 2nd of every month", Monthly)
      == %Repeatex{days: %{tuesday: 3}, type: :monthly, frequency: 1}

    assert Tokenizer.tokenize("on the 2nd and 3rd tuesday of every month", Monthly)
      == %Repeatex{days: [2], type: :monthly, frequency: 1}
    # TODO: allow specifying multiple weeks per day
  end
end
