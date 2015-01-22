Repeatex
========

Repeatex is still under active development and currently only supports parsing natural language into a data structure. Here's a simple example:

```elixir
Repeatex.Parser.parse "daily"
#  %Repeatex.Repeat{days: [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday], frequency: 1, type: :weekly}
```

# Installation

As repeatex isn't finished yet, you'll need to specify this repository location to use in your projects:
```elixir
{:repeatex, github: "rcdilorenzo/repeatex"}
```

# Contribution

If you would like to contribute to the parser of other parts of this project, please check out the [demo](http://rcdilorenzo.github.io/repeatex), and find other expressions that still need to be parsed, filing issues as needed. Even better, feel free to tackle any issues in the repository by submitting a friendly pull-request. Thanks!

# Examples

"every other monday"
```elixir
%Repeatex.Repeat{days: [:monday], frequency: 2, type: :weekly}
```

"each tues"
```elixir
%Repeatex.Repeat{days: [:tuesday], frequency: 1, type: :weekly}
```

"mon-sat every week"
```elixir
%Repeatex.Repeat{days: [:monday, :tuesday, :wednesday, :thursday, :friday,
  :saturday], frequency: 1, type: :weekly}
```

"every 3rd of the month"
```elixir
%Repeatex.Repeat{days: [3], frequency: 1, type: :monthly}
```

"1st and 3rd every 2 months"
```elixir
%Repeatex.Repeat{days: [1, 3], frequency: 2, type: :monthly}
```

"on the 3rd tuesday of every month"
```elixir
%Repeatex.Repeat{days: [{3, :tuesday}], frequency: 1, type: :monthly}
```

# TODO - Parsing

- [ ] "weekly on thursdays"
- [ ] "quarterly on the 1st of the month"
- [ ] "on the third tuesday of each month"

