defmodule Repeatex.Formatter.Daily do
  @behaviour Repeatex.Formatter

  def format(repeat) do
    case repeat do
      %Repeatex{type: type} when type != :daily -> nil
      %Repeatex{frequency: 1} -> "daily"
      %Repeatex{frequency: 2} -> "every other day"
      %Repeatex{frequency: num} when is_integer(num) -> "every #{num} days"
      _ -> nil
    end
  end

end
