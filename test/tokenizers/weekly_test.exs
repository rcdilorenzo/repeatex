defmodule Tokenizers.WeeklyTest do
  use ExUnit.Case
  alias Repeatex.Tokenizer.Weekly
  alias Repeatex.Tokenizer

  test "validating days" do
    refute Weekly.valid_days?([])
    refute Weekly.valid_days?([:tuesday, :friday, "other"])
    refute Weekly.valid_days?([:monday, :monday, :saturday])
    assert Weekly.valid_days?([:monday, :wednesday, :saturday])
  end

  test "should return nil when invalid" do
    refute Tokenizer.tokenize("", Weekly)
    refute Tokenizer.tokenize(nil, Weekly)
    refute Tokenizer.tokenize("every day", Weekly)
    refute Tokenizer.tokenize("every year", Weekly)
    refute Tokenizer.tokenize("3rd of every month", Weekly)
    refute Tokenizer.tokenize("I love weeks", Weekly)
    refute Tokenizer.tokenize("on the 3rd tuesday of every month", Weekly)
  end

  test "parsing days" do
    assert Weekly.days("Every other week on Mon and Wed") == [:monday, :wednesday]
  end

  test "parses single day" do
    assert Tokenizer.tokenize("every other monday", Weekly)
      == %Repeatex{days: [:monday], type: :weekly, frequency: 2}

    assert Tokenizer.tokenize("every week on thursday", Weekly)
      == %Repeatex{days: [:thursday], type: :weekly, frequency: 1}

    assert Tokenizer.tokenize("on thursdays", Weekly)
      == %Repeatex{days: [:thursday], type: :weekly, frequency: 1}

    assert Tokenizer.tokenize("each wed", Weekly)
      == %Repeatex{days: [:wednesday], type: :weekly, frequency: 1}

    assert Tokenizer.tokenize("every 2nd tuesday", Weekly)
      == %Repeatex{days: [:tuesday], type: :weekly, frequency: 2}
  end

  test "parses sequential days" do
    assert Tokenizer.tokenize("mon-sat weekly", Weekly)
      == %Repeatex{days: [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday], type: :weekly, frequency: 1}

    assert Tokenizer.tokenize("every week on mon-sat", Weekly)
      == %Repeatex{days: [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday], type: :weekly, frequency: 1}

    assert Tokenizer.tokenize("every week on fri-sun", Weekly)
      == %Repeatex{days: [:sunday, :friday, :saturday], type: :weekly, frequency: 1}

    assert Tokenizer.tokenize("every week on fri-mon", Weekly)
      == %Repeatex{days: [:sunday, :monday, :friday, :saturday], type: :weekly, frequency: 1}

    assert Tokenizer.tokenize("biweekly on sat", Weekly)
      == %Repeatex{days: [:saturday], type: :weekly, frequency: 2}
  end
end
