Repeatex
========

![Test Status](https://travis-ci.org/rcdilorenzo/repeatex.svg)
![MIT License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)
<br>

![Repeatex](logo.png)

Repeatex is a library for parsing, scheduling, and formatting repeating events. It handles many different expressions from "daily" to "on the 2nd tuesday and 4rd thursday of every other month". See [Usage](#usage) and [Examples](#example) for more detail.

# Usage

## Parsing

```elixir
Repeatex.parse("mon-sat every week")
# %Repeatex{
#   days: [
#     monday
#     tuesday
#     wednesday
#     thursday
#     friday
#     saturday
#   ]
#   frequency: 1
#   type: weekly
# }
```

```elixir
Repeatex.parse("mumbo jumbo")
# nil
```


## Scheduling

```elixir
repeatex = %Repeatex{days: [], frequency: 2, type: :daily}
Repeatex.next_date(repeatex, {2016, 1, 5}) # => {2016, 1, 7}
```

```elixir
repeatex = %Repeatex{days: [:friday, :monday], frequency: 2, type: :weekly}
Repeatex.next_date(repeatex, {2016, 1, 5}) # => {2016, 1, 8}
```

```elixir
repeatex = %Repeatex{days: [{3, :tuesday}], frequency: 1, type: :monthly}
Repeatex.next_date(repeatex, {2016, 1, 5}) # => {2016, 1, 19}
```


## Formatting

```elixir
repeatex = %Repeatex{days: [{3, :tuesday}], frequency: 1, type: :monthly}
Repeatex.description(repeatex)
# => "3rd Tue every month"
```

```elixir
repeatex = %Repeatex{days: [:monday], frequency: 1, type: :weekly}
Repeatex.description(repeatex)
# => "Every week on Mon"
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
Repeatex.parse("every other day")
# %Repeatex{
#   days: [
#   ]
#   frequency: 2
#   type: daily
# }
```

```elixir
Repeatex.parse("every other monday")
# %Repeatex{
#   days: [
#     monday
#   ]
#   frequency: 2
#   type: weekly
# }
```

```elixir
Repeatex.parse("each tues")
# %Repeatex{
#   days: [
#     tuesday
#   ]
#   frequency: 1
#   type: weekly
# }
```

```elixir
Repeatex.parse("mon-sat every week")
# %Repeatex{
#   days: [
#     monday
#     tuesday
#     wednesday
#     thursday
#     friday
#     saturday
#   ]
#   frequency: 1
#   type: weekly
# }
```

```elixir
Repeatex.parse("every 3rd of the month")
# %Repeatex{
#   days: [
#     3
#   ]
#   frequency: 1
#   type: monthly
# }
```

```elixir
Repeatex.parse("1st and 3rd every 2 months")
# %Repeatex{
#   days: [
#     1
#     3
#   ]
#   frequency: 2
#   type: monthly
# }
```

```elixir
Repeatex.parse("on the 3rd tuesday of every month")
# %Repeatex{
#   days: [
#     {
#       3
#       tuesday
#     }
#   ]
#   frequency: 1
#   type: monthly
# }
```


# TODO - Parsing

- [ ] "weekly on thursdays"
- [ ] "1st of every quarter"
- [ ] "on the third tuesday of each month"

# Roadmap

- [x] Parsing natural language
- [x] Validate parsed structure
- [ ] Scheduler to determine next date - **Daily, Weekly, and Monthly are done**
- [x] Output natural description of repeat

# License

Copyright (c) 2015-2016 Christian Di Lorenzo

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
