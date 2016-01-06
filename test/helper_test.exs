defmodule HelperTest do
  use Amrita.Sweet
  import Repeatex.Helper

  it "determines next day of week" do
    next_allowed_day(:monday, [:tuesday, :saturday]) |> equals :tuesday
  end

  it "finds the next number in a list" do
    next_number([1, 4, 6], 5) |> equals 6
    next_number([1, 3], 5) |> equals 1
    next_number([4, 22], 3) |> equals 4
  end
end
