defmodule Repeatex.Formatter.Daily do
  @behaviour Repeatex.Formatter

  def format(repeat) do
    case repeat do
      %Repeatex{type: type} when type != :daily -> nil
      %Repeatex{frequency: 1} -> "Daily"
      %Repeatex{frequency: 2} -> "Every other day"
      %Repeatex{frequency: num} when is_integer(num) -> "Every #{num} days"
      _ -> nil
    end
  end

end
