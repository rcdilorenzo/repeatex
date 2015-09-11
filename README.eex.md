Repeatex
========

![Test Status](https://travis-ci.org/rcdilorenzo/repeatex.svg)
![MIT License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)
<br>

![Repeatex](logo.png)

Repeatex is still under active development. See the roadmap for the current features in progress or planned. The scheduler is now in progress and parsing and formatting is at a stable version.

<%= insert.("daily") %>

# Installation

As repeatex isn't finished yet, you'll need to specify this repository location to use in your projects:
```elixir
{:repeatex, github: "rcdilorenzo/repeatex"}
```

# Contribution

If you would like to contribute to the parser of other parts of this project, please check out the [demo](http://rcdilorenzo.github.io/repeatex), and find other expressions that still need to be parsed, filing issues as needed. Even better, feel free to tackle any issues in the repository by submitting a friendly pull-request. Thanks!

# Examples

<%= examples %>

# TODO - Parsing

<%= pending %>

# Roadmap

- [x] Parsing natural language
- [x] Validate parsed structure
- [ ] Scheduler to determine next date - **in progress**
- [x] Output natural description of repeat

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
