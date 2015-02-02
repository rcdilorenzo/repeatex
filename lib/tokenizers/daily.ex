defmodule Repeatex.Tokenizer.Daily do
  alias Repeatex.Repeat
  import Repeatex.Helper

  @frequency %{
    ~r/every.*other.*day/ => 2,
    ~r/((every|each).day|daily)/ => 1,
    ~r/(every|each).(?<digit>\d+)[\w\s]{0,3}day/ => "digit"
  }

  def tokenize(nil), do: nil
  def tokenize(description) do
    case %Repeat{type: type(description), frequency: frequency(description)} do
      %Repeat{frequency: nil} -> nil
      %Repeat{type: type} when type != :daily -> nil
      repeat -> repeat
    end
  end

  defp type(description) do
    if Regex.match?(~r/(days?|daily)/, description), do: :daily
  end

  defp frequency(description) do
    @frequency |> Enum.find_value fn
      ({regex, freq}) when is_integer(freq) ->
        if Regex.match?(regex, description), do: freq
      ({regex, key}) when is_binary(key) ->
        if Regex.match?(regex, description) do
          Regex.named_captures(regex, description)[key] |> String.to_integer
        end
    end
  end

end
