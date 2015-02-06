defmodule RepeatexTest do
  use Amrita.Sweet
  alias Repeatex.Parser, as: Parser
  alias Repeatex.Repeat

  it "should parse using default modules" do
    Parser.parse("every day")
      |> equals %Repeat{days: [], type: :daily, frequency: 1}

    Parser.parse("mon-wed every week")
      |> equals %Repeat{days: [:monday, :tuesday, :wednesday], type: :weekly, frequency: 1}
  end

end
