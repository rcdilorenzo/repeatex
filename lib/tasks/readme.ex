defmodule Mix.Tasks.Repeatex.Readme do
  use Mix.Task
  require EEx

  @readme_eex "README.eex.md"
  @readme     "README.md"

  @shortdoc "Generate internal README from current code state"

  @examples [
    "every other day",
    "every other monday",
    "each tues",
    "mon-sat every week",
    "every 3rd of the month",
    "1st and 3rd every 2 months",
    "on the 3rd tuesday of every month"
  ]

  @pending [
    "weekly on thursdays",
    "1st of every quarter",
    "on the third tuesday of each month"
  ]

  def run(_) do
    examples = @examples |> Enum.filter(&Repeatex.parse/1)
                         |> Enum.map(&parse/1)
                         |> Enum.join("\n")
    pending = @pending |> Enum.map(&( "- [ ] \"#{&1}\""))
                       |> Enum.join("\n")
    content = EEx.eval_file(@readme_eex, [
      parse: &parse/1,
      schedule: &schedule/2,
      format: &format/1,
      today: today,
      examples: examples, pending: pending
    ])
    File.write!(@readme, content)
  end

  def parse(description) do
    """
    ```elixir
    Repeatex.parse("#{description}")
    # #{Repeatex.parse(description) |> pretty_format}
    ```
    """
  end

  def schedule(repeatex, date) do
    """
    ```elixir
    repeatex = #{repeatex |> to_str}
    Repeatex.next_date(repeatex, #{date |> to_str}) # => #{Repeatex.next_date(repeatex, date) |> to_str}
    ```
    """
  end

  def format(repeatex) do
    """
    ```elixir
    repeatex = #{repeatex |> to_str}
    Repeatex.description(repeatex)
    # => #{Repeatex.description(repeatex) |> to_str}
    ```
    """
  end

  def today do
    {date, _} = :calendar.local_time
    date
  end

  def to_str(item, opts \\ []) do
    opts = struct(Inspect.Opts, opts)
    Inspect.Algebra.format(Inspect.Algebra.to_doc(item, opts), 100)
      |> to_string
  end

  def pretty_format(item) do
    Apex.Format.format(item, color: false)
      |> String.replace("\n", "\n# ")
      |> String.replace("Elixir.", "")
      |> String.replace(~r/\[.\]\s/, "")
      |> String.slice(0..-4)
  end
end
