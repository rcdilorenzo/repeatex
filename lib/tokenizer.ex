defmodule Repeatex.Tokenizer do
  @callback tokenize(String.t) :: Repeatex.t | nil

  import Repeatex.Helper, only: [concat_modules: 1]

  def parse(description) do
    concat_modules(__MODULE__)
      |> Enum.find_value &(&1.tokenize(description))
  end
end
