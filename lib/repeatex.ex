defmodule Repeatex do
  defstruct type: :unknown, frequency: 0, days: []

  def parse(description) do
    Repeatex.Tokenizer.parse(description)
  end

  def parse_json(map) do
    Repeatex.Tokenizer.parse_json(map)
  end

  def next_date(repeatex, date) do
    Repeatex.Scheduler.next(repeatex, date)
  end

  def description(repeatex) do
    Repeatex.Formatter.format(repeatex)
  end

end
