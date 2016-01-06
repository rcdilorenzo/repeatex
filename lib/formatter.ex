defmodule Repeatex.Formatter do
  @callback format(Repeatex.t) :: String.t | nil

  import Repeatex.Helper, only: [concat_modules: 1]

  def format(description) do
    concat_modules(__MODULE__)
      |> Enum.find_value &(&1.format(description))
  end
end

