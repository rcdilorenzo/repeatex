defmodule Repeatex.Formatter.Daily do
  alias Repeatex.Repeat

  def format(%Repeat{} = repeat) do
    case repeat do
      %Repeat{type: type} when type != :daily -> nil
      %Repeat{frequency: 1} -> "daily"
      %Repeat{frequency: 2} -> "every other day"
      %Repeat{frequency: num} when is_integer(num) -> "every #{num} days"
      _ -> nil
    end
  end

end
