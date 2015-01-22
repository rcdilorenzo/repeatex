Repeatex
========


- [x] "daily"
```elixir
%Repeatex.Repeat{days: [:sunday, :monday, :tuesday, :wednesday, :thursday,
  :friday, :saturday], frequency: 1, type: :weekly}
```

- [x] "every other monday"
```elixir
%Repeatex.Repeat{days: [:monday], frequency: 2, type: :weekly}
```

- [x] "each tues"
```elixir
%Repeatex.Repeat{days: [:tuesday], frequency: 1, type: :weekly}
```

- [x] "mon-sat every week"
```elixir
%Repeatex.Repeat{days: [:monday, :tuesday, :wednesday, :thursday, :friday,
  :saturday], frequency: 1, type: :weekly}
```

- [x] "every 3rd of the month"
```elixir
%Repeatex.Repeat{days: [3], frequency: 1, type: :monthly}
```

- [x] "1st and 3rd every 2 months"
```elixir
%Repeatex.Repeat{days: [1, 3], frequency: 2, type: :monthly}
```

- [x] "on the 3rd tuesday of every month"
```elixir
%Repeatex.Repeat{days: [{3, :tuesday}], frequency: 1, type: :monthly}
```

- [ ] "weekly on thursdays"

- [ ] "quarterly on the 1st of the month"

- [ ] "on the third tuesday of each month"

