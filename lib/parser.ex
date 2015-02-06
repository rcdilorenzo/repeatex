defmodule Repeatex.Parser do
  alias Repeatex.Tokenizer, as: Tokenizer

  @modules [Daily, Weekly, Monthly]

  @all [ :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday ]

  # def __using__(modules: modules \\ [Tokenizer.Weekly]) do
  #   @modules modules
  # end

  def parse(description) do
    @modules |> concat_modules |> Enum.find_value fn (module) ->
      module.tokenize(description)
    end
  end

  defp concat_modules(modules) do
    modules |> Enum.map fn (module) ->
      try do
        Module.safe_concat(Repeatex.Tokenizer, module)
      rescue
        ArgumentError -> module
      end
    end
  end

end
