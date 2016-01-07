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

  it "converts a map to atom keys" do
    assert convert_map(%{
      "type" => "monthly",
      "days" => %{"monday" => 1, "thursday" => 3},
      "frequency" => 2
    }) == %{
      type: :monthly,
      days: %{monday: 1, thursday: 3},
      frequency: 2
    }

    assert convert_map(%{
      "type" => "weekly",
      "days" => ["monday", "thursday"],
      "frequency" => 2
    }) == %{
      type: :weekly,
      days: [:monday, :thursday],
      frequency: 2
    }

    assert convert_map(%{
      "type" => "not_already_defined_as_an_atom",
      "days" => ["monday", "thursday"],
      "frequency" => 2
    }) == %{
      type: "not_already_defined_as_an_atom",
      days: [:monday, :thursday],
      frequency: 2
    }
  end
end
