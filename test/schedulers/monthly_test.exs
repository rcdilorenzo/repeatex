defmodule Schedulers.MonthlyTest do
  use ExUnit.Case
  alias Repeatex.Scheduler.Monthly

  test "schedules numbered days of the month" do
    assert Monthly.next_date(repeat([1, 3], 1), {2015, 1, 4}) == {2015, 2, 1}
    assert Monthly.next_date(repeat([4, 10], 1), {2015, 1, 6}) == {2015, 1, 10}

    assert Monthly.next_date(repeat([4, 10], 2), {2015, 3, 21}) == {2015, 5, 4}
    assert Monthly.next_date(repeat([4, 7, 12], 4), {2015, 10, 14}) == {2016, 2, 4}

    assert Monthly.next_date(repeat([4, 7, 12], 4), {2015, 10, 7}) == {2015, 10, 12}
  end

  test "schedules relative week days" do
    assert Monthly.next_date(repeat([{3, :tuesday}], 1), {2016, 1, 1}) == {2016, 1, 19}
    assert Monthly.next_date(repeat([{2, :monday}, {3, :tuesday}], 1), {2016, 1, 1}) == {2016, 1, 11}
    assert Monthly.next_date(repeat([{1, :monday}, {3, :tuesday}], 1), {2016, 1, 31}) == {2016, 2, 1}
    assert Monthly.next_date(repeat([{3, :tuesday}, {1, :monday}], 2), {2016, 1, 31}) == {2016, 3, 7}
  end

  test "can find relative week days of the month" do
    assert Monthly.day_of_month({{2016, 2}, {3, :wednesday}}) == {2016, 2, 17}
    assert Monthly.day_of_month({{2016, 2}, {2, :sunday}}) == {2016, 2, 14}
  end

  defp repeat(days, frequency) do
    %Repeatex{days: days, type: :monthly, frequency: frequency}
  end

end
