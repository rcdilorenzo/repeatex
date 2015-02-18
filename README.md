Repeatex
========

![Test Status](https://travis-ci.org/rcdilorenzo/repeatex.svg)
![MIT License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)
<br>

![Repeatex](logo.png)

Repeatex is still under active development and currently only supports parsing natural language into a data structure. Here's a simple example:

```elixir
Repeatex.Parser.parse "daily"
# %Repeatex.Repeat{days: [], frequency: 1, type: :daily}
```


# Installation

As repeatex isn't finished yet, you'll need to specify this repository location to use in your projects:
```elixir
{:repeatex, github: "rcdilorenzo/repeatex"}
```

# Contribution

If you would like to contribute to the parser of other parts of this project, please check out the [demo](http://rcdilorenzo.github.io/repeatex), and find other expressions that still need to be parsed, filing issues as needed. Even better, feel free to tackle any issues in the repository by submitting a friendly pull-request. Thanks!

# Examples

```elixir
Repeatex.Parser.parse "every other day"
# %Repeatex.Repeat{days: [], frequency: 2, type: :daily}
```

```elixir
Repeatex.Parser.parse "every other monday"
# %Repeatex.Repeat{days: [:monday], frequency: 2, type: :weekly}
```

```elixir
Repeatex.Parser.parse "each tues"
# %Repeatex.Repeat{days: [:tuesday], frequency: 1, type: :weekly}
```

```elixir
Repeatex.Parser.parse "mon-sat every week"
# %Repeatex.Repeat{days: [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday], frequency: 1, type: :weekly}
```

```elixir
Repeatex.Parser.parse "every 3rd of the month"
# %Repeatex.Repeat{days: [3], frequency: 1, type: :monthly}
```

```elixir
Repeatex.Parser.parse "1st and 3rd every 2 months"
# %Repeatex.Repeat{days: [1, 3], frequency: 2, type: :monthly}
```

```elixir
Repeatex.Parser.parse "on the 3rd tuesday of every month"
# %Repeatex.Repeat{days: [{3, :tuesday}], frequency: 1, type: :monthly}
```


# TODO - Parsing

- [ ] "weekly on thursdays"
- [ ] "1st of every quarter"
- [ ] "on the third tuesday of each month"

# Roadmap

- [ ] Parsing natural language - **in progress**
- [ ] Validate parsed structure
- [ ] Scheduler to determine next date
- [ ] Output natural description of repeat

# License

Copyright (c) 2015 Christian Di Lorenzo

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
