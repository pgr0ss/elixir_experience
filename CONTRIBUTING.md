# Contributing

- [Fork](https://github.com/pgr0ss/elixir_experience/fork), then clone the repo: `git clone git@github.com:your-username/elixir_experience.git`
- Create a feature branch: `git checkout -b feature_branch`
- Make your changes (see how to [Propose Problems](#propose-problems) below)
- Make sure the tests pass: `mix test`
- Create an [issue](https://github.com/pgr0ss/elixir_experience/issues/new)
- Push your feature branch: `git push origin feature_branch`
- Submit a pull request referencing the issue created

### Propose Problems
Problems require the following:
- Number (this is a sequence, the next integer should be fine)
- Description (question as the struct field) should include example/guide
- Solution (this is required for the problem to be included in the test suite)
- Test is a test of equality, actual should be wrapped in strings and expected should be the elixir term, see example in [Sample Problem](#sample-problem). It should not run longer than 5 seconds, this includes the load/shutdown time for the docker container

Problems are listed in [problems.exs](config/problems.exs)
Append your proposed problem to the list of problems, see [Sample Problem](#sample-problem) below and follow instructions to submit a pull request.

Thanks!


### Sample Problem
```elixir
  %Problem{
    number: 001,
    question: """
    Write a function called add that takes two numbers and returns their sum, e.g.:

    add(1, 2) #=> 3
    """,
    solution: """
    def add(x, y) do
      x + y
    end
    """,
    tests: [
      ["add(1, 1)", 2],
      ["add(3, 6)", 9],
      ["add(4, 4)", 8],
    ]
  },
```
