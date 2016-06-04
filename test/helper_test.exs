defmodule HelperTest do
  use ExUnit.Case
  import Repeatex.Helper

  test "determines next day of week" do
    assert next_allowed_day(:monday, [:tuesday, :saturday]) == :tuesday
  end

  test "finds the next number in a list" do
    assert next_number([1, 4, 6], 5) == 6
    assert next_number([1, 3], 5) == 1
    assert next_number([4, 22], 3) == 4
  end

  test "converts a map to atom keys" do
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
