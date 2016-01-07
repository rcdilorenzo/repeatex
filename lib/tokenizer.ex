defmodule Repeatex.Tokenizer do
  @callback type(String.t) :: Atom.t | nil
  @callback days(String.t) :: Enum.t | Map.t | nil
  @callback frequency(String.t) :: Integer.t | nil

  @callback type() :: Atom.t
  @callback valid_days?(Enum.t) :: boolean

  import Repeatex.Helper, only: [concat_modules: 1, convert_map: 1]

  def parse(description) when is_binary(description) do
    concat_modules(__MODULE__)
      |> Enum.find_value &(tokenize(description, &1))
  end
  def parse(_), do: nil

  def parse_json(%{type: type, days: days, frequency: frequency}) when is_atom(type) and frequency > 0 do
    modules = concat_modules(__MODULE__)
    case Enum.find(modules, &(&1.type == type)) do
      nil -> nil
      module -> parse_map(module, days, frequency)
    end
  end
  def parse_json(map = %{"type" => _, "days" => _, "frequency" => _}) do
    convert_map(map) |> parse_json
  end
  def parse_json(_), do: nil

  def tokenize("", _), do: nil
  def tokenize(description, module) when is_binary(description) do
    struct = %Repeatex{
      type: module.type(description),
      days: module.days(description),
      frequency: module.frequency(description)
    }
    cond do
      is_nil(struct.type) or
        is_nil(struct.days) or
        is_nil(struct.frequency) -> nil
      true -> struct
    end
  end
  def tokenize(_, _), do: nil

  def parse_map(module, days, frequency) do
    if module.valid_days?(days) do
      %Repeatex{type: module.type, days: days, frequency: frequency}
    end
  end
end
