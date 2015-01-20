defmodule RepeatexTest do
  use Amrita.Sweet

  facts "repeat form" do
    fact "is weekly" do
      assert Repeatex.Parser.weekly? "every week on thursday"
      assert Repeatex.Parser.weekly? "on thursday weekly"
      assert Repeatex.Parser.weekly? "weekly on thursdays"
    end

    fact "is monthly" do
      assert Repeatex.Parser.monthly? "every month on the 1st"
      assert Repeatex.Parser.monthly? "on the 1st of every month"
      assert Repeatex.Parser.monthly? "monthly on the 1st"
      assert Repeatex.Parser.monthly? "every 1st of the month"
    end

    fact "is yearly" do
      assert Repeatex.Parser.yearly? "annually on Jan 1"
      assert Repeatex.Parser.yearly? "Jan 1 of every year"
      assert Repeatex.Parser.yearly? "Jan 1 yearly"
    end
  end

  facts "tokenizing days" do

    fact "parses single day" do
      Repeatex.Tokenizer.days("every week on thursday")
        |> [:thursday]
    end

    fact "parses sequential days" do
      Repeatex.Tokenizer.days("every week on mon-sat")
        |> [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday]

      Repeatex.Tokenizer.days("every week on fri-sun")
        |> [:sunday, :friday, :saturday]

      Repeatex.Tokenizer.days("every week on fri-mon")
        |> [:sunday, :monday, :friday, :saturday]
    end

  end

  facts "tokenizer helpers" do

    fact "finds sequential days" do
      Repeatex.Helper.seq_days(:monday, :wednesday)
        |> [:monday, :tuesday, :wednesday]

      Repeatex.Helper.seq_days(:friday, :monday)
        |> [:sunday, :monday, :friday, :saturday]
    end

  end

end
