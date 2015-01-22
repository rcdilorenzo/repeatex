defmodule RepeatexTest do
  use Amrita.Sweet
  alias Repeatex.Parser, as: Parser

  facts "repeat struct" do

    it "converts repeat description" do
      Parser.parse("mondays and wednesdays every other week")
        |> equals %Repeatex.Repeat{type: :weekly, frequency: 2, days: [:monday, :wednesday]}

      Parser.parse("march 26 annually")
        |> equals %Repeatex.Repeat{type: :yearly, frequency: 1, days: [march: 26]}
    end
  end

  facts "repeat form" do
    fact "is weekly" do
      assert Parser.weekly? "every week on thursday"
      assert Parser.weekly? "on thursday weekly"
      assert Parser.weekly? "weekly on thursdays"

      refute Parser.monthly? "weekly on thursdays"
      refute Parser.yearly? "weekly on thursdays"
    end

    fact "is monthly" do
      assert Parser.monthly? "every month on the 1st"
      assert Parser.monthly? "on the 1st of every month"
      assert Parser.monthly? "monthly on the 1st"
      assert Parser.monthly? "every 1st of the month"

      refute Parser.weekly? "every 1st of the month"
      refute Parser.yearly? "every 1st of the month"
    end

    fact "is yearly" do
      assert Parser.yearly? "annually on Jan 1"
      assert Parser.yearly? "Jan 1 of every year"
      assert Parser.yearly? "Jan 1 yearly"

      refute Parser.weekly? "Jan 1 yearly"
      refute Parser.monthly? "Jan 1 yearly"
    end
  end

end
