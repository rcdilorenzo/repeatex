defmodule Repeatex.Helper do

  @day_patterns %{
    sunday: ~r/sun(day)?/,
    monday: ~r/mon(day)?/,
    tuesday: ~r/tues?(day)?/,
    wednesday: ~r/wedn?e?s?(day)?/,
    thursday: ~r/thurs?(day)?/,
    friday: ~r/fri(day)?/,
    saturday: ~r/satu?r?(day)?/,
  }

  @months %{
    january:   ~r/jan(uary)?/i,
    february:  ~r/feb(ruary)?/i,
    march:     ~r/mar(ch)?/i,
    april:     ~r/apr(il)?/i,
    may:       ~r/may/i,
    june:      ~r/june?/i,
    july:      ~r/july?/i,
    august:    ~r/aug(ust)?/i,
    september: ~r/sep(tember)?/i,
    october:   ~r/oct(uary)?/i,
    november:  ~r/nov(ember)?/i,
    december:  ~r/dec(ember)?/i,
  }

  @days [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]
  @days_index Enum.reduce(@days, %{}, fn (day, map) -> Map.put(map, day, Enum.find_index(@days, &(&1 == day))) end)

  defmacro __using__(_opts) do
    quote do
      import unquote(__MODULE__)
      alias Repeatex.Repeat

      Module.register_attribute __MODULE__, :frequency_matches, accumulate: true
      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def frequency(description) do
        @frequency_matches |> Enum.find_value fn
          ({regex, freq}) when is_integer(freq) ->
            if Regex.match?(regex, description), do: freq
          ({regex, key}) when is_binary(key) ->
            if Regex.match?(regex, description) do
              Regex.named_captures(regex, description)[key] |> String.to_integer
            end
        end
      end
    end
  end

  defmacro match_type(type, regex) do
    quote do
      def type(description) do
        if Regex.match?(unquote(regex), description), do: unquote(type)
      end
    end
  end

  defmacro match_freq(return, regex) do
    quote do
      @frequency_matches {unquote(regex), unquote(return)}
    end
  end


  def seq_days(start, end_day) when start in @days and end_day in @days do
    @days |> Enum.filter &in_day_range?(@days_index[&1], @days_index[start], @days_index[end_day])
  end

  def find_month(month_description) do
    @months |> Enum.find_value fn ({atom, regex}) ->
      if Regex.match?(regex, month_description), do: atom
    end
  end

  def find_day(description) do
    find_days(description) |> List.first
  end

  def find_days(description) do
    @day_patterns |> Enum.filter_map fn ({_, regex}) ->
      Regex.match? regex, description
    end, (fn ({atom, _}) -> atom end)
  end


  def valid_month?(month) when is_atom(month) do
    month in Map.keys(@months)
  end



  defp in_day_range?(index, first_index, second_index) when first_index > second_index do
    (index >= first_index) or (index <= second_index)
  end
  defp in_day_range?(index, first_index, second_index) do
    (index >= first_index) and (index <= second_index)
  end

end
