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
    examples = @examples |> Enum.filter(&Repeatex.Parser.parse/1)
                         |> Enum.map(&insert/1)
                         |> Enum.join("\n")
    pending = @pending |> Enum.map(&( "- [ ] \"#{&1}\""))
                       |> Enum.join("\n")
    content = EEx.eval_file(@readme_eex, [
      insert: &insert/1, examples: examples, pending: pending
    ])
    File.write!(@readme, content)
  end

  def insert(description) do
    """
    ```elixir
    Repeatex.Parser.parse "#{description}"
    # #{Repeatex.Parser.parse(description) |> to_str}
    ```
    """
  end

  def to_str(item, opts \\ []) do
    opts = struct(Inspect.Opts, opts)
    Inspect.Algebra.format(Inspect.Algebra.to_doc(item, opts), 500)
  end
end
